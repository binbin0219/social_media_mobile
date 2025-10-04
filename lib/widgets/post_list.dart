import 'package:flutter/material.dart';
import 'package:social_media_mobile/main.dart';
import 'package:social_media_mobile/widgets/Post.dart' as post_widget;
import 'package:social_media_mobile/models/post.dart' as post_model;
import 'package:social_media_mobile/widgets/inifinite_scroll_list.dart';

class PostList extends StatelessWidget {
  final int recordPerPage = 10;
  const PostList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(24),
      child: InifiniteScrollList<post_model.Post>(
        recordPerPage: recordPerPage,
        fetchData: (offset) async {
          final response = await api.call("GET", "/api/post/get?offset=$offset&recordPerPage=$recordPerPage");
          return (response.data as List).map((post) => post_model.Post.fromJson(post)).toList();
        },
        itemBuilder:(post, index, posts) => post_widget.Post(post: post),
      ),
    );
  }
}
