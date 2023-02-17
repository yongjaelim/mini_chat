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
  bool startedPlaying = false;

  @override
  void initState() {
    _videoController = VideoPlayerController.file(widget.video);
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
              child: videoPlayer(context)),
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
                _videoController.value.isPlaying
                    ? Icons.pause
                    : Icons.play_arrow,
              ),
            )
          : Container(),
    );
  }

  Widget videoPlayer(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: AspectRatio(
                    aspectRatio: _videoController.value.aspectRatio,
                    child: VideoPlayer(_videoController),
                  ),
                ),
                Row(  
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: _videoController,
                      builder: (context, VideoPlayerValue value, child) {
                        return Text(
                          _videoDuration(value.position),
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        );
                      },
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 20,
                        child: VideoProgressIndicator(
                          _videoController,
                          allowScrubbing: true,
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 12),
                        ),
                      ),
                    ),
                    Text(_videoDuration(_videoController.value.duration),
                      style: const TextStyle(
                        fontSize: 20,
                      ),),
                  ],
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<bool> started() async {
    await _videoController.initialize();
    await _videoController.play();
    startedPlaying = true;
    return true;
  }

  String _videoDuration(Duration duration) {
    print(_videoController.value.duration);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) {
        hours,
        minutes,
        seconds,
      }
    ].join(':');
  }

}
