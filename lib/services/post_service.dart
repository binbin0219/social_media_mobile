import 'package:social_media_mobile/main.dart';

class PostService {
  Future<void> likePost(int postId) async {
    final response = await api.call("POST", "/api/like/post", data: {
      "action": "like",
      "post_id": postId
    });

    if(response.statusCode != 200) {
      throw Exception("Failed to like post");
    }
  }

  Future<void> unlikePost(int postId) async {
    final response = await api.call("POST", "/api/like/post", data: {
      "action": "unlike",
      "post_id": postId
    });

    if(response.statusCode != 200) {
      throw Exception("Failed to unlike post");
    }
  }
}