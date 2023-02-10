import 'package:photo_manager/photo_manager.dart';

class ImageModel {
  List<AssetPathEntity>? _albums;
  final List<AssetEntity> _images = [];
  int _page = 0;
  final int _sizePerPage = 20;

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
    if(_page==0){
      var addCamera = const AssetEntity(id: 'camera', typeInt: 0, width: 0, height: 0);
      loadImages.insert(0, addCamera);
    }

    // setState(() {
    //   _images.addAll(loadImages);
    //   _page++;
    // });
  }
}