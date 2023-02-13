import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:image_picker/image_picker.dart';

import 'full_screen.dart';

class GridPhoto extends StatefulWidget {
  List<AssetEntity> images;

  GridPhoto({
    required this.images,
    Key? key,
  }) : super(key: key);

  @override
  State<GridPhoto> createState() => _GridPhotoState();
}

class _GridPhotoState extends State<GridPhoto> {
  final picker = ImagePicker();
  final chosenList = <AssetEntity>[];

  void _getCamera() async {
    final XFile? photoFile = await picker.pickImage(source: ImageSource.camera);
    if (photoFile != null) {
      GallerySaver.saveImage(photoFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: RefreshIndicator(
        color: Colors.white,
        backgroundColor: Colors.blue,
        onRefresh: () async {
          setState(() {
            print('refresh');
          });
        },
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: widget.images.map((e) {
            if (e.id == 'camera') {
              return _cameraButton();
            } else {
              return _photoItem(e);
            }
          }).toList(),
        ),
      ),
    );
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

  Widget _photoItem(AssetEntity e) {
    return GestureDetector(
      onDoubleTap: () async {
        File video = await e.file as File;
        if(!mounted) return;
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => FullScreenImage(e, video)));
      },
      onLongPress: () async {
        File video = await e.file as File;
        if(!mounted) return;
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => FullScreenImage(e, video)));
      },
      onTap: () async {
        if (chosenList.contains(e)) {
          chosenList.remove(e);
        } else {
          chosenList.add(e);
        }
        print(chosenList);
        setState(() {});
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
            child: !chosenList.contains(e)
                ? Container(
                    //padding: const EdgeInsets.all(10.0),
                    // decoration: BoxDecoration(
                    //   color: Colors.white,
                    //   border: Border.all(
                    //     color: Colors.blueAccent,
                    //   ),
                    //   borderRadius: BorderRadius.circular(5.0),
                    // ),
                    // child: const Icon(
                    //   Icons.check_box_outline_blank_outlined,
                    //   color: Colors.white,
                    // ),
                    )
                : Container(
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
                      child: Text((chosenList.indexOf(e) + 1).toString()),
                    )),
          ),
        ],
      ),
    );
  }
}
