import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'grid_photo.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({Key? key}) : super(key: key);

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  List<AssetPathEntity>? _albums;
  final List<AssetEntity> _images = [];
  int _page = 0;
  final int _sizePerPage = 20;

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  Future<void> checkPermission() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      await getPhotos();
    } else {
      await PhotoManager.openSetting();
    }
  }

  Future<void> getPhotos() async {
    _albums = await PhotoManager.getAssetPathList(
      hasAll: true,
      type: RequestType.common,
    );

    final loadImages =
    await _albums![0].getAssetListPaged(page: _page, size: _sizePerPage);
    if(_page==0) {
      var addCamera = const AssetEntity(id: 'camera', typeInt: 0, width: 0, height: 0);
      loadImages.insert(0, addCamera);
    }
    print(loadImages);

    setState(() {
      _images.addAll(loadImages);

      _page++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('recent'),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scroll) {
          scrollNotification(scroll);

          return false;
        },
        child: SafeArea(
          child: _albums == null
              ? const Center(child: CircularProgressIndicator(),)
              : GridPhoto(images: _images),
        ),
      ),
    );
  }

  void scrollNotification(scroll){
    if (scroll.metrics.maxScrollExtent * 0.7 < scroll.metrics.pixels){
      getPhotos();
    }
  }
}
