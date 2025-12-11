import 'package:flutter/material.dart';
import 'package:social_media_mobile/models/post.dart';
import 'package:social_media_mobile/models/post_comment.dart' as post_comment_model;
import 'package:social_media_mobile/widgets/user_avatar.dart';

class PostComment extends StatefulWidget {
  final Post post;
  final post_comment_model.PostComment comment;
  const PostComment({
    super.key,
    required this.post,
    required this.comment
  });

  @override
  _PostCommentState createState() => _PostCommentState();
}

class _PostCommentState extends State<PostComment> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserAvatar(
          userId: widget.comment.user.id,
          width: 40,
          height: 40,
        ),

        const SizedBox(width: 8),
        
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Colors.grey
          ),
          child: Text(widget.comment.content),
        )
      ],
    );
  }
}