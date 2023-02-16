import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/video_player.dart';
import '../models/image_model.dart';

class ImageViewModel with ChangeNotifier {
  late ImageModel _imageModel;
  late VideoPlayerController videoController;
  List<AssetPathEntity>? _albums;
  bool _onTouch = true;

  final int _sizePerPage = 20;
  final Set<AssetEntity> _images = {};
  final List<AssetEntity> _chosenList = <AssetEntity>[];

  ImageViewModel() {
    _imageModel = ImageModel();
    checkPermission();
    getPhotos();
  }

  bool get onTouch => _onTouch;
  List<AssetPathEntity>? get albums => _albums;

  Set<AssetEntity> get images => _images;

  List<AssetEntity> get chosenList => _chosenList;

  void setOnTouch() {
    _onTouch = false;
  }

  void addPhotoToChosenList(AssetEntity photo) {
    _chosenList.add(photo);
    notifyListeners();
  }

  void playVideo() {
    videoController.play();
    notifyListeners();
  }

  void pauseVideo() {
    videoController.pause();
    notifyListeners();
  }

  void deletePhotoFromChosenList(AssetEntity photo) {
    _chosenList.remove(photo);
    notifyListeners();
  }

  Future<void> getPhotos() async {
    _albums = await _imageModel.getAlbums();

    final loadImages =
        await _albums![0]
            .getAssetListPaged(page: _imageModel.page, size: _sizePerPage);

    if (_imageModel.page == 0) {
      var addCamera =
          const AssetEntity(id: 'camera', typeInt: 0, width: 0, height: 0);
      loadImages.insert(0, addCamera);
    }

    _images.addAll(loadImages);
    _imageModel.updatePage();
    notifyListeners();
  }

  Future<void> checkPermission() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      await getPhotos();
    } else {
      await PhotoManager.openSetting();
    }
  }
}
