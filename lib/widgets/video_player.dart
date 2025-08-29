import 'dart:async';

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
  Timer? _hideControlTimer;
  bool _showControl = false;
  final double fullVolume = 0.5;

  @override
  void initState() {
    super.initState();
    _controller = video_player_package.VideoPlayerController.networkUrl(
      Uri.parse(widget.url),
    );
    _controller.initialize().then((_) async {
      setState(() {});
      _controller.play();
      _controller.setVolume(0.5);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _hideControlTimer?.cancel();
    super.dispose();
  }

  void _triggerHideControlTimer() {
    _hideControlTimer?.cancel();
    _hideControlTimer = Timer(const Duration(seconds: 5), () {
      setState(() {
        _showControl = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    } else {
      return ValueListenableBuilder(
        valueListenable: _controller,
        builder: (context, value, child) {
          final Duration duration = _controller.value.duration;
          final Duration position = _controller.value.position;

          return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: GestureDetector(
              onTap: () {
                if (_showControl == true) {
                  setState(() {
                    _showControl = false;
                  });
                } else {
                  setState(() {
                    _showControl = true;
                  });
                  _triggerHideControlTimer();
                }
              },
              child: Stack(
                children: [
                  video_player_package.VideoPlayer(_controller),

                  if (_showControl)
                    Stack(
                      children: [
                        Container(color: Colors.black.withOpacity(0.5)),

                        if (!_controller.value.isPlaying)
                          Center(
                            child: IconButton(
                              onPressed: () {
                                _controller.play();
                                _triggerHideControlTimer();
                              },
                              icon: const Icon(Icons.play_circle),
                              iconSize: 70,
                              color: Color.fromARGB(148, 168, 168, 168),
                            ),
                          )
                        else
                          Center(
                            child: IconButton(
                              onPressed: () {
                                _controller.pause();
                                _hideControlTimer?.cancel();
                                setState(() {
                                  _showControl = true;
                                });
                              },
                              icon: const Icon(Icons.pause_circle),
                              iconSize: 70,
                              color: Color.fromARGB(148, 168, 168, 168),
                            ),
                          ),

                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: EdgeInsetsGeometry.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "${position.inMinutes < 10 ? 0 : ''}${position.inMinutes}:${position.inSeconds < 10 ? 0 : ''}${position.inSeconds} / ${duration.inMinutes < 10 ? 0 : ''}${duration.inMinutes}:${duration.inSeconds < 10 ? 0 : ''}${duration.inSeconds}",
                                  style: TextStyle(color: Colors.white),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      // thumbShape: SliderComponentShape.noThumb
                                    ), 
                                    child: Slider(
                                      padding: EdgeInsets.zero,
                                      activeColor: Colors.grey,
                                      min: 0,
                                      max:
                                          _controller
                                              .value
                                              .duration
                                              .inMilliseconds
                                              .toDouble(),
                                      value: _controller
                                          .value
                                          .position
                                          .inMilliseconds
                                          .toDouble()
                                          .clamp(
                                            0,
                                            _controller
                                                .value
                                                .duration
                                                .inMilliseconds
                                                .toDouble(),
                                          ),
                                      onChanged: (value) {
                                        _controller.seekTo(
                                          Duration(milliseconds: value.toInt()),
                                        );
                                        _controller.play();
                                      },
                                    )
                                  )
                                ),

                                const SizedBox(width: 10),
                                
                                if(_controller.value.volume >= fullVolume)
                                  InkWell(
                                    onTap: () async {
                                      await _controller.setVolume(0);
                                      setState(() {});
                                    },
                                    child: const Icon(Icons.volume_up_outlined, color: Colors.white, size: 25,),
                                  )
                                else
                                  InkWell(
                                    onTap: () async {
                                      await _controller.setVolume(fullVolume);
                                      setState(() {});
                                    },
                                    child: const Icon(Icons.volume_off_outlined, color: Colors.white, size: 25,),
                                  )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      );
    }
  }
}
