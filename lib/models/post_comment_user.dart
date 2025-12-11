class PostCommentUser {
  final int id;
  final String username;
  final DateTime? updatedAt;

  PostCommentUser({
    required this.id,
    required this.username,
    this.updatedAt
  });

  factory PostCommentUser.fromJson(Map<String, dynamic> json) {
    return PostCommentUser(
      id: json['id'], 
      username: json['username'], 
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null
    );
  }
}