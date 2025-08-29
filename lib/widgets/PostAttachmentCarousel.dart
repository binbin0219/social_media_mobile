import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:social_media_mobile/models/post_attachment.dart';
import 'dart:ui' as ui;

import 'package:social_media_mobile/widgets/SmartImage.dart';
import 'package:social_media_mobile/widgets/video_player.dart';

class PostAttachmentCarousel extends StatefulWidget {
  final int postId;
  final List<PostAttachment> attachments;

  const PostAttachmentCarousel({
    super.key,
    required this.postId,
    required this.attachments,
  });

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
    final canNext = _index < widget.attachments.length - 1;

    void goto(int i) {
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
            itemCount: widget.attachments.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (context, index) {
              final PostAttachment attachment = widget.attachments[index];
              final bool isVideo = attachment.mimeType.startsWith("video");
              return Center(
                child: Stack(
                  children: [
                    if (!isVideo)
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          ImageFiltered(
                            imageFilter: ui.ImageFilter.blur(
                              sigmaX: 100,
                              sigmaY: 100,
                            ),
                            child: Image.network(
                              attachment.getUrl(widget.postId),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder:
                                  (context, error, stackTrace) =>
                                      const Icon(Icons.error),
                            ),
                          ),

                          SmartImage(url: attachment.getUrl(widget.postId)),
                        ],
                      )
                    else
                      VideoPlayer(url: attachment.getUrl(widget.postId)),
                  ],
                ),
              );
            },
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
                  onPressed: () => canBack ? goto(_index - 1) : null,
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
                  onPressed: () => goto(_index + 1),
                  icon: const Icon(Icons.chevron_right, color: Colors.white),
                ),
              ),
            ),

          Positioned(
            left: null,
            right: 5,
            top: 5,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.45),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "${_index + 1} / ${widget.attachments.length}",
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
