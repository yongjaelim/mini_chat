import 'package:flutter/material.dart';
import 'package:mini_chat/views/grid_photo_view.dart';
import 'package:provider/provider.dart';
import '../view_models/image_view_model.dart';

class ImageView extends StatelessWidget {
  const ImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ImageViewModel>(
      builder: (context, imageViewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('recent'),
          ),
          body: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scroll) {
              scrollNotification(scroll, imageViewModel);
              return false;
            },
            child: SafeArea(
              child: imageViewModel.albums == null
                  ? const Center(child: CircularProgressIndicator(),)
                  : GridPhotoView(imageViewModel),
            ),
          ),
        );
      }
    );
  }

  void scrollNotification(ScrollNotification scroll, ImageViewModel imageViewModel) {
    if (scroll.metrics.maxScrollExtent * 0.7 < scroll.metrics.pixels){
      imageViewModel.getPhotos();
    }
  }
}
