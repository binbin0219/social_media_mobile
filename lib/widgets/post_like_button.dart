import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_mobile/providers/post_service_provider.dart';
import 'package:social_media_mobile/services/post_service.dart';

class PostLikeButton extends ConsumerStatefulWidget {
  final int postId;
  final int likeCount;
  final bool liked;

  const PostLikeButton({
    super.key,
    required this.postId,
    required this.likeCount,
    required this.liked
  });

  @override
  ConsumerState<PostLikeButton> createState() => PostLikeButtonState();
}

class PostLikeButtonState extends ConsumerState<PostLikeButton> {
  late bool _liked;
  late PostService _postService;

  @override
  void initState() {
    super.initState();
    _liked = widget.liked;
    _postService = ref.read(postServiceProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          final bool oldLikeState = _liked;
          try {
            final int postId = widget.postId;
            setState(() {
              _liked = !_liked;
            });
            oldLikeState == true ? await _postService.unlikePost(postId) : await _postService.likePost(postId);
          } on Exception catch(e) {
            print("Failed to like post: $e");
            setState(() {
              _liked = oldLikeState;
            });
          }
        },
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          child: Row(
            children: [
              Icon(
                _liked ?
                Icons.favorite :
                Icons.favorite_border, 
                color: Colors.red
              ),
              const SizedBox(width: 6),
              Text(
                widget.likeCount.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 6),
              Text(
                "Likes",
                style: TextStyle(
                  color: const Color.fromARGB(255, 111, 112, 112),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}