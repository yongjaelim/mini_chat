import 'package:photo_manager/photo_manager.dart';

class ImageModel {

  Future<List<AssetPathEntity>?> getAlbums() async {
    List<AssetPathEntity>? albums = await PhotoManager.getAssetPathList(
      hasAll: true,
      type: RequestType.common,
    );

    return albums;
  }
}