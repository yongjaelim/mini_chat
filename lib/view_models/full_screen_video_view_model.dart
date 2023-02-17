import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideoViewModel with ChangeNotifier {
  AssetEntity _assetEntity = const AssetEntity(id: 'sample', typeInt: 0, width: 0, height: 0);
  File _file = File('');

  AssetEntity get assetEntity => _assetEntity;
  File get file => _file;

  void setAssetEntity(AssetEntity assetEntity) {
    _assetEntity = assetEntity;
    notifyListeners();
  }

  Future<void> setFile(AssetEntity e) async {
    _file = await assetEntity.file as File;
    notifyListeners();
  }



  // void playVideo() {
  //   videoController.play();
  //   notifyListeners();
  // }
  //
  // void pauseVideo() {
  //   videoController.pause();
  //   notifyListeners();
  // }

}