import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

import '../view_models/full_screen_image_view_model.dart';

class FullScreenImageView extends StatelessWidget {
  const FullScreenImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FullScreenImageViewModel>(
      builder: (context, fullScreenImageViewModel, child) {
        return Scaffold(
            appBar: AppBar(),
            body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: AssetEntityImage(
                fullScreenImageViewModel.assetEntity,
                isOriginal: true,
                fit: BoxFit.contain,
              ),
            ));
      },
    );
  }
}
