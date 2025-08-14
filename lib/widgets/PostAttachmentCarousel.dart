import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:social_media_mobile/widgets/SmartImage.dart';

class PostAttachmentCarousel extends StatefulWidget {
  const PostAttachmentCarousel({super.key});

  @override
  State<StatefulWidget> createState() => PostAttachmentCarouselState();
}

class PostAttachmentCarouselState extends State<PostAttachmentCarousel> {
  late final PageController _controller;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    final canBack = _index > 0;
    final canNext = _index < 1;

    void _goto(int i) {
      try {
        _controller.animateToPage(
          i,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      } catch (e) {
        print("Failed to go to $i page: $e");
      }
    }

    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: 2,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder:
                (context, index) => Center(
                  child: Stack(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          ImageFiltered(
                            imageFilter: ui.ImageFilter.blur(
                              sigmaX: 100,
                              sigmaY: 100,
                            ),
                            child: Image.network(
                              index == 1
                                  ? 'https://media.istockphoto.com/id/517188688/photo/mountain-landscape.jpg?s=612x612&w=0&k=20&c=A63koPKaCyIwQWOTFBRWXj_PwCrR4cEoOw2S9Q7yVl8='
                                  : 'https://images.unsplash.com/photo-1715731456131-d4c3697a20f0?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8Z3JlZW4lMjBuYXR1cmV8ZW58MHx8MHx8fDA%3D',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),

                          SmartImage(
                            url:
                                index == 1
                                    ? 'https://media.istockphoto.com/id/517188688/photo/mountain-landscape.jpg?s=612x612&w=0&k=20&c=A63koPKaCyIwQWOTFBRWXj_PwCrR4cEoOw2S9Q7yVl8='
                                    : 'https://images.unsplash.com/photo-1715731456131-d4c3697a20f0?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8Z3JlZW4lMjBuYXR1cmV8ZW58MHx8MHx8fDA%3D',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          ),

          if (canBack)
            Positioned.fill(
              left: 0,
              right: null,
              child: Align(
                child: IconButton.filled(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      Colors.black.withValues(alpha: 0.6),
                    ),
                  ),
                  onPressed: () => canBack ? _goto(_index - 1) : null,
                  icon: const Icon(Icons.chevron_left),
                ),
              ),
            ),

          if (canNext)
            Positioned.fill(
              right: 0,
              left: null,
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton.filled(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      Colors.black.withValues(alpha: 0.6),
                    ),
                  ),
                  onPressed: () => _goto(_index + 1),
                  icon: const Icon(Icons.chevron_right, color: Colors.white),
                ),
              ),
            ),

          Positioned(
            left: null,
            right: 0,
            top: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.45),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "${_index + 1} / 2",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
