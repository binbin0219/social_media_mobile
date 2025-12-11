import 'package:social_media_mobile/models/has_id.dart';
import 'package:social_media_mobile/models/post_comment_user.dart';

class PostComment implements HasId {
  @override
  final int id;
  final String content;
  final PostCommentUser user;
  final DateTime createAt;

  PostComment({
    required this.id,
    required this.content,
    required this.user,
    required this.createAt
  });

  factory PostComment.fromJson(Map<String, dynamic> json) {
    return PostComment(
      id: json['id'], 
      content: json['content'], 
      user: PostCommentUser.fromJson(json['user']), 
      createAt: DateTime.parse(json['createAt'])
    );
  }
}