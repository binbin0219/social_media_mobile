import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart' as video_player_package;

class VideoPlayer extends StatefulWidget {
  final String url;

  const VideoPlayer({super.key, required this.url});

  @override
  State<StatefulWidget> createState() => VideoPlayerState();
}

class VideoPlayerState extends State<VideoPlayer> {
  late video_player_package.VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = video_player_package.VideoPlayerController.networkUrl(Uri.parse(widget.url));
    _controller.initialize()
    .then((_) async {
      setState(() {});
      await _controller.play();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(!_controller.value.isInitialized) {
      return Container();
    } else {
      return Stack(
        children: [
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio, 
            child: video_player_package.VideoPlayer(_controller)
          ),
          
          if(!_controller.value.isPlaying)
            Positioned(
              child: IconButton(
                onPressed: () {
                  _controller.play();
                }, 
                icon: Icon(Icons.play_circle),
                iconSize: 70,
                color: const Color.fromARGB(150, 0, 0, 0),
              )
            ),

          if(_controller.value.isPlaying)
            Positioned(
              child: IconButton(
                onPressed: () {
                  _controller.pause();
                }, 
                icon: Icon(Icons.pause_circle),
                iconSize: 70,
                color: const Color.fromARGB(150, 0, 0, 0),
              )
            )
        ],
      );
    }
  }
}