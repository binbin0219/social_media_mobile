import 'package:social_media_mobile/models/post_attachment.dart';

class Post {
  final int id;
  final String title;
  final String content;
  final String create_at;
  final int commentCount;
  final int likeCount;
  final List<dynamic> comments;
  final List<PostAttachment> attachments;
  final bool? isNew;
  final bool liked;
  final dynamic user;
  final int? userId;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.create_at,
    required this.commentCount,
    required this.likeCount,
    required this.comments,
    required this.attachments,
    this.isNew,
    required this.liked,
    this.user,
    this.userId
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json["id"] ?? 0, 
      title: json["title"] ?? "", 
      content: json["content"] ?? "", 
      create_at: json["create_at"] ?? "", 
      commentCount: json["commentCount"] ?? 0, 
      likeCount: json["likeCout"] ?? 0, 
      comments: json["comments"] ?? [], 
      attachments: (json["attachments"] as List).map((attachment) => PostAttachment.fromJson(attachment)).toList(),
      liked: json["liked"] ?? false,
      user: json["user"],
      userId: json["userId"]
    );
  }
}