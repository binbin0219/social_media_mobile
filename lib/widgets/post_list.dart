import 'package:flutter/material.dart';
import 'package:social_media_mobile/main.dart';
import 'package:social_media_mobile/utils/utils.dart';
import 'package:social_media_mobile/widgets/Post.dart' as post_widget;
import 'package:social_media_mobile/models/post.dart' as post_model;
import 'package:social_media_mobile/widgets/inifinite_scroll_list.dart';

class PostList extends StatefulWidget {
  final int recordPerPage = 10;
  const PostList({super.key});

  @override
  State<StatefulWidget> createState() => PostListState();
}

class PostListState extends State<PostList> {
  List<post_model.Post> _posts = [];
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(24),
      child: InifiniteScrollList<post_model.Post>(
        recordPerPage: widget.recordPerPage,
        data: _posts,
        fetchData: (offset) async {
          final response = await api.call("GET", "/api/post/get?offset=$offset&recordPerPage=${widget.recordPerPage}");
          final posts = (response.data as List).map((post) => post_model.Post.fromJson(post)).toList();
          setState(() {
            _posts = mergeItemsWithUniqueId(_posts, posts);
          });
          return posts.length;
        },
        itemBuilder:(post, index, posts) => post_widget.Post(post: post),
      ),
    );
  }
}
