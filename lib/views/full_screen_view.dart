import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mini_chat/view_models/image_view_model.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class FullScreenView extends StatelessWidget {
  const FullScreenView(this.e, this.video, {Key? key}) : super(key: key);

  final AssetEntity e;
  final File video;

  @override
  Widget build(BuildContext context) {
    late Future<void> initializeVideoPlayerFuture;

    return Consumer<ImageViewModel>(
      builder: (context, imageViewModel, child) {
        imageViewModel.videoController = VideoPlayerController.file(video);
        initializeVideoPlayerFuture =
            imageViewModel.videoController.initialize();
        print('mvvm full screen');
        return Scaffold(
          appBar: AppBar(),
          body: e.type == AssetType.image
              ? SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: AssetEntityImage(
                    e,
                    isOriginal: true,
                    fit: BoxFit.contain,
                  ),
                )
              : SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: videoPlayer(
                    context,
                    imageViewModel.videoController,
                    initializeVideoPlayerFuture,
                  ),
                ),
          floatingActionButton: e.type == AssetType.video
              ? FloatingActionButton(
                  onPressed: () {
                    if (imageViewModel.videoController.value.isPlaying) {
                      imageViewModel.videoController.pause();
                    } else {
                      imageViewModel.videoController.play();
                    }
                  },
                  child: Icon(
                    imageViewModel.videoController.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                )
              : Container(),
        );
      },
    );
  }

  Widget videoPlayer(
      BuildContext context,
      VideoPlayerController videoPlayerController,
      Future<void> initializeVideoPlayerFuture) {
    return FutureBuilder(
      future: initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: videoPlayerController.value.aspectRatio,
            child: VideoPlayer(videoPlayerController),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
