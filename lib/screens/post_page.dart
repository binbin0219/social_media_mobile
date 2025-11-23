import 'package:flutter/material.dart';
import 'package:social_media_mobile/models/post.dart' as post_model;
import 'package:social_media_mobile/widgets/Post.dart' as post_widget;
import 'package:social_media_mobile/widgets/post_header.dart';

class PostPage extends StatefulWidget {

  const PostPage({super.key});

  @override
  State<StatefulWidget> createState() => PostPageState();
}

class PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    final post = ModalRoute.of(context)!.settings.arguments as post_model.Post;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0,
        title: PostHeader()
      ),
      body: post_widget.Post(
        post: post,
      ),
    );
  }
}