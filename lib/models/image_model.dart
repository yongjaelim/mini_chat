import 'package:photo_manager/photo_manager.dart';

class ImageModel {
  List<AssetPathEntity>? _albums;
  final Set<AssetEntity> _images = {};

  Set<AssetEntity> get images => _images;

  void addImages(List<AssetEntity> loadImages) {
    _images.addAll(loadImages);
  }

  Future<List<AssetPathEntity>?> getAlbums() async {
    _albums = await PhotoManager.getAssetPathList(
      hasAll: true,
      type: RequestType.common,
    );

    return _albums;
  }
}