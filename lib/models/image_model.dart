import 'package:photo_manager/photo_manager.dart';

class ImageModel {
  List<AssetPathEntity>? _albums;
  int _page = 0;
  final Set<AssetEntity> _images = {};

  int get page => _page;
  Set<AssetEntity> get images => _images;

  void addImages(List<AssetEntity> loadImages) {
    _images.addAll(loadImages);
  }

  void updatePage() {
    _page++;
  }

  Future<List<AssetPathEntity>?> getAlbums() async {
    _albums = await PhotoManager.getAssetPathList(
      hasAll: true,
      type: RequestType.common,
    );

    return _albums;
  }
}