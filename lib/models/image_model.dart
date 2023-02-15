import 'package:photo_manager/photo_manager.dart';

class ImageModel {
  List<AssetPathEntity>? _albums;
  int _pageStart = 0;
  int _pageEnd = 19;
  int _page = 0;
  final Set<AssetEntity> _images = {};

  int get pageStart => _pageStart;
  int get pageEnd => _pageEnd;
  int get page => _page;
  Set<AssetEntity> get images => _images;

  void addImages(List<AssetEntity> loadImages) {
    _images.addAll(loadImages);
  }

  void updatePage() {
    _pageStart += 20;
    _pageEnd += 20;
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