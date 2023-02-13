import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import '../models/image_model.dart';

class ImageViewModel with ChangeNotifier {
  late ImageModel _imageModel;
  List<AssetPathEntity>? _albums;
  int _page = 0;
  final int _sizePerPage = 20;
  final List<AssetEntity> _images = <AssetEntity>[];
  final List<AssetEntity> _chosenList = <AssetEntity>[];

  ImageViewModel() {
    _imageModel = ImageModel();
  }

  List<AssetPathEntity>? get albums => _albums;
  List<AssetEntity> get images => _images;
  List<AssetEntity> get chosenList => _chosenList;

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
    await _albums![0].getAssetListPaged(page: _page, size: _sizePerPage);

    if(_page==0) {
      var addCamera = const AssetEntity(id: 'camera', typeInt: 0, width: 0, height: 0);
      loadImages.insert(0, addCamera);
    }

    _images.addAll(loadImages);
    _page++;
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