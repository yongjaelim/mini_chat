import 'package:mini_chat/models/image_model.dart';
import 'package:photo_manager/photo_manager.dart';

class MediaRepository {

  final ImageModel _imageModel = ImageModel();
  final Set<AssetEntity> _images = {};
  Set<AssetEntity> get images => _images;

  void addImages(List<AssetEntity> loadImages) {
    _images.addAll(loadImages);
  }

  Future<List<AssetPathEntity>?> getAlbums() {
    return _imageModel.getAlbums();
  }
}