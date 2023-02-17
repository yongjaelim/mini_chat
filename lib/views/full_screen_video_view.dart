import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mini_chat/view_models/full_screen_video_view_model.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideoView extends StatelessWidget {
  const FullScreenVideoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FullScreenVideoViewModel>(
      builder: (context, fullScreenVideoViewModel, child) {
        VideoPlayerController videoPlayerController =
            VideoPlayerController.file(fullScreenVideoViewModel.file);
        return Scaffold(
          appBar: AppBar(),
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: videoPlayer(
              context,
              videoPlayerController,
              videoPlayerController.initialize(),
            ),
          ),
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
          return Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: AspectRatio(
                  aspectRatio: videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(videoPlayerController),
                ),
              ),
              Row(
                children: [
                  ValueListenableBuilder(
                    valueListenable: videoPlayerController,
                    builder: (context, VideoPlayerValue value, child) {
                      return Text(
                        _videoDuration(value.position),
                        style: const TextStyle(fontSize: 20),
                      );
                    },
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 20,
                      child: VideoProgressIndicator(
                        videoPlayerController,
                        allowScrubbing: true,
                        padding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 10,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    _videoDuration(videoPlayerController.value.duration),
                    style: const TextStyle(fontSize: 20),
                  )
                ],
              ),
              ValueListenableBuilder(
                valueListenable: videoPlayerController,
                builder: (context, VideoPlayerValue value, child) {
                  return IconButton(
                      onPressed: () {
                        value.isPlaying
                            ? videoPlayerController.pause()
                            : videoPlayerController.play();
                      },
                      icon: Icon(
                        value.isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 40,
                      ));
                },
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  String _videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }
}
