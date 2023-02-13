import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/video_player.dart';

class FullScreenImage extends StatefulWidget {
  final AssetEntity e;
  final File video;

  const FullScreenImage(this.e, this.video, {super.key});

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  late VideoPlayerController _videoController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _videoController = VideoPlayerController.file(
        widget.video);
    _initializeVideoPlayerFuture = _videoController.initialize();

    super.initState();
  }

  @override
  void dispose() {
    _videoController.dispose();

    super.dispose();
  }


  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: widget.e.type == AssetType.image
          ? SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: AssetEntityImage(
                widget.e,
                isOriginal: true,
                fit: BoxFit.contain,
              ),
            )
          : SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: videoPlayer(context)
            ),
      floatingActionButton: widget.e.type == AssetType.video
        ? FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_videoController.value.isPlaying) {
              _videoController.pause();
            } else {
              _videoController.play();
            }
          });
        },
        child: Icon(
          _videoController.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ) : Container(),
    );
  }

  Widget videoPlayer(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: _videoController.value.aspectRatio,
            child: VideoPlayer(_videoController),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
