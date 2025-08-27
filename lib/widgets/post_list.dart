import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:social_media_mobile/main.dart';
import 'package:social_media_mobile/widgets/Post.dart' as post_widget;
import 'package:social_media_mobile/models/post.dart' as post_model;

class PostList extends StatefulWidget {
  const PostList({super.key});

  @override
  State<StatefulWidget> createState() => PostListState();
}

class PostListState extends State<PostList> {
  final List<post_model.Post> _posts = [];
  final ScrollController _scrollController = ScrollController();

  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    try {
      final response = await api.call("GET", "/api/post/get?offset=${_posts.length}&recordPerPage=6");
      final fetchedPosts = (response.data as List).map((post) => post_model.Post.fromJson(post));

      setState(() {
        _posts.addAll(fetchedPosts);
      });
    } on DioException catch (e) {
      print("Failed to fetch posts: $e");
      setState(() {
        _isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(24),
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        return post_widget.Post(post: _posts[index]);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 20),
    );
  }
}