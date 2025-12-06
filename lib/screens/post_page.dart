import 'package:flutter/material.dart';
import 'package:social_media_mobile/models/post.dart' as post_model;
import 'package:social_media_mobile/widgets/PostAttachmentCarousel.dart';
import 'package:social_media_mobile/widgets/PostContent.dart';
import 'package:social_media_mobile/widgets/post_card.dart' as post_widget;
import 'package:social_media_mobile/widgets/post_comment_button.dart';
import 'package:social_media_mobile/widgets/post_header.dart';
import 'package:social_media_mobile/widgets/post_like_button.dart';
import 'package:social_media_mobile/widgets/user_avatar.dart';

class PostPage extends StatefulWidget {

  const PostPage({super.key});

  @override
  State<StatefulWidget> createState() => PostPageState();
}

class PostPageState extends State<PostPage> {
  final EdgeInsetsGeometry _pagePadding = 
    EdgeInsetsGeometry.directional(start: 8);
  @override
  Widget build(BuildContext context) {
    final post = ModalRoute.of(context)!.settings.arguments as post_model.Post;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0,
        title: PostHeader(userId: post.user.id)
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const SizedBox(height: 8),

          Padding(
            padding: _pagePadding,
            child: Column(
              children: [

                Text(
                  post.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22
                  ),
                ),

                const SizedBox(height: 4),

                Postcontent(content: post.content),
              ],
            ),
          ),

          const SizedBox(height: 16),

          PostAttachmentCarousel(postId: post.id, attachments: post.attachments),

          const SizedBox(height: 16),

          Padding(
            padding: _pagePadding,
            child: Row(
              children: [
                PostLikeButton(postId: post.id, likeCount: post.likeCount, liked: post.liked),
                PostCommentButton(commentCount: post.commentCount)
              ],
            ),
          ),

          const SizedBox(height: 16),

          Padding(
            padding: _pagePadding,
            child: Row(
              children: [

                UserAvatar(
                  userId: post.user.id,
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
                  child: Text('asdasdasdasd'),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}