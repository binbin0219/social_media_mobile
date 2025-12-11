import 'package:flutter/material.dart';
import 'package:social_media_mobile/main.dart';
import 'package:social_media_mobile/models/post.dart' as post_model;
import 'package:social_media_mobile/models/post_comment.dart' as post_comment_model;
import 'package:social_media_mobile/utils/utils.dart';
import 'package:social_media_mobile/widgets/PostAttachmentCarousel.dart';
import 'package:social_media_mobile/widgets/PostContent.dart';
import 'package:social_media_mobile/widgets/inifinite_scroll_list.dart';
import 'package:social_media_mobile/widgets/post_card.dart' as post_widget;
import 'package:social_media_mobile/widgets/post_comment.dart' as post_comment_widget;
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
  List<post_comment_model.PostComment> _comments = [];
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

          Expanded(
            child: InifiniteScrollList<post_comment_model.PostComment>(
              recordPerPage: 10, 
              itemBuilder: (comment, index) {
                return Padding(
                  padding: _pagePadding,
                  child: post_comment_widget.PostComment(post: post, comment: comment)
                );
              }, 
              fetchData: (index) async {
                final response = await api.call(
                  "GET", 
                  "/api/comment/get?postId=${post.id}&recordPerPage=10&offset=${_comments.length}"
                );
                final fetchedComments = (response.data['comments'] as List)
                  .map((c) => post_comment_model.PostComment.fromJson(c))
                  .toList();

                setState(() {
                  _comments = mergeItemsWithUniqueId(fetchedComments, _comments);
                });

                return fetchedComments.length;
              }, 
              data: _comments
            )
          )
        ],
      )
    );
  }
}