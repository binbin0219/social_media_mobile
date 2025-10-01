class ChatRoomMember {
  final String id;
  final String chatRoomId;
  final int userId;
  final String username;
  final DateTime? userUpdatedAt;

  ChatRoomMember({
    required this.id,
    required this.chatRoomId,
    required this.userId,
    required this.username,
    required this.userUpdatedAt
  });

  factory ChatRoomMember.fromJson(Map<String, dynamic> json) {
    return ChatRoomMember(
      id: json['id'], 
      chatRoomId: json['chatRoomId'], 
      userId: json['userId'], 
      username: json['username'], 
      userUpdatedAt: json['userUpdatedAt'] != null ? DateTime.parse(json['userUpdatedAt']) : null
    );
  }
}