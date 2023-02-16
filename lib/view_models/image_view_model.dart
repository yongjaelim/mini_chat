import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/video_player.dart';
import '../models/image_model.dart';

class ImageViewModel with ChangeNotifier {
  late ImageModel _imageModel;
  late VideoPlayerController videoController;
  List<AssetPathEntity>? _albums;
  int _page = 0;

  final int _sizePerPage = 20;
  final Set<AssetEntity> _images = {};
  final List<AssetEntity> _chosenList = <AssetEntity>[];

  ImageViewModel() {
    _imageModel = ImageModel();
    checkPermission();
  }

  List<AssetPathEntity>? get albums => _albums;

  Set<AssetEntity> get images => _images;

  List<AssetEntity> get chosenList => _chosenList;

  int get page => _page;

  void updatePage() {
    _page++;
  }

  void addPhotoToChosenList(AssetEntity photo) {
    _chosenList.add(photo);
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
            .getAssetListPaged(page: _page, size: _sizePerPage);

    if (_page == 0) {
      var addCamera =
          const AssetEntity(id: 'camera', typeInt: 0, width: 0, height: 0);
      loadImages.insert(0, addCamera);
    }

    _images.addAll(loadImages);
    updatePage();
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

  void playVideo() {
    videoController.play();
    notifyListeners();
  }

  void pauseVideo() {
    videoController.pause();
    notifyListeners();
  }
}
