import 'package:photo_manager/photo_manager.dart';

class ImageModel {
  List<AssetPathEntity>? _albums;

  Future<List<AssetPathEntity>?> getAlbums() async {
    _albums = await PhotoManager.getAssetPathList(
      hasAll: true,
      type: RequestType.common,
    );

    return _albums;
  }
}