import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_chat/view_models/image_view_model.dart';
import 'package:photo_manager/photo_manager.dart';

import '../full_screen.dart';

class GridPhotoView extends StatelessWidget {
  GridPhotoView(this.images, this._imageViewModel, {Key? key}) : super(key: key);
  List<AssetEntity> images;
  final ImageViewModel _imageViewModel;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: RefreshIndicator(
        color: Colors.white,
        backgroundColor: Colors.blue,
        onRefresh: () async {
          return null;
        },
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: images.map((e) {
            if (e.id == 'camera') {
              return _cameraButton();
            } else {
              return _photoItem(e, context);
            }
          }).toList(),
        ),
      ),
    );
  }

  void _getCamera() async {
    final XFile? photoFile = await picker.pickImage(source: ImageSource.camera);
    if (photoFile != null) {
      GallerySaver.saveImage(photoFile.path);
    }
  }

  IconButton _cameraButton() {
    return IconButton(
      onPressed: _getCamera,
      icon: const Icon(
        Icons.camera_alt_outlined,
        color: Colors.black,
      ),
    );
  }

  Widget _photoItem(AssetEntity e, BuildContext context) {
    return GestureDetector(
      onDoubleTap: () async {
        File video = await e.file as File;
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => FullScreenImage(e, video)));
      },
      onLongPress: () async {
        File video = await e.file as File;
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => FullScreenImage(e, video)));
      },
      onTap: () async {
        if (_imageViewModel.chosenList.contains(e)) {
          _imageViewModel.deletePhotoFromChosenList(e);
        } else {
          _imageViewModel.addPhotoToChosenList(e);
        }
        print('mvvm');
        print(_imageViewModel.chosenList);
      },
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: AssetEntityImage(
              e,
              isOriginal: false,
              fit: BoxFit.cover,
            ),
          ),
          e.type == AssetType.video ? const Align(
            alignment: Alignment.bottomRight,
            child: Icon(
              Icons.videocam,
              color: Colors.white,
            ),
          )
              : Container(),
          Positioned(
            right: 5,
            top: 5,
            child: !_imageViewModel.chosenList.contains(e) ? Container() :
            Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: Text((_imageViewModel.chosenList.indexOf(e) + 1).toString()),
                )),
          ),
        ],
      ),
    );
  }
}
