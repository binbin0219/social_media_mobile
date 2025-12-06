import 'package:flutter/material.dart';
import 'package:social_media_mobile/widgets/PostAttachmentCarousel.dart';
import 'package:social_media_mobile/widgets/PostContent.dart';
import 'package:social_media_mobile/models/post.dart' as post_model;
import 'package:social_media_mobile/widgets/post_comment_button.dart';
import 'package:social_media_mobile/widgets/post_header.dart';
import 'package:social_media_mobile/widgets/post_like_button.dart';

class PostCard extends StatefulWidget {
  final post_model.Post post;
  final bool showHeader;

  const PostCard({super.key, required this.post, this.showHeader = true});

  @override
  State<StatefulWidget> createState() => PostCardState();
}

class PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          if(widget.showHeader) ...[
            PostHeader(),
            const SizedBox(height: 12)
          ],

          Align(
            alignment: Alignment.topLeft,
            child: Text(
              widget.post.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 6),

          Align(alignment: Alignment.topLeft, child: Postcontent(content: widget.post.content)),

          const SizedBox(height: 12),

          if(widget.post.attachments.isNotEmpty) 
            PostAttachmentCarousel(attachments: widget.post.attachments, postId: widget.post.id),

          const SizedBox(height: 25),

          Row(
            children: [
              PostLikeButton(
                postId: widget.post.id, 
                likeCount: widget.post.likeCount, 
                liked: widget.post.liked
              ),

              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context, 
                    "/post",
                    arguments: widget.post
                  );
                },
                child: PostCommentButton(commentCount: widget.post.commentCount)
              ),
            ],
          ),
        ],
      ),
    );
  }
}
