import 'package:social_media_mobile/models/chat_room_member.dart';
import 'package:social_media_mobile/models/has_id.dart';

class ChatRoom implements HasId {
  final String id;
  final String name;
  final String type;
  final String messagePreview;
  final DateTime lastMessageAt;
  final int unreadCount;
  final List<ChatRoomMember> members;

  ChatRoom({
    required this.id,
    required this.name,
    required this.type,
    required this.messagePreview,
    required this.lastMessageAt,
    required this.unreadCount,
    required this.members,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      messagePreview: json['messagePreview'] ?? '',
      lastMessageAt: DateTime.parse(json['lastMessageAt']),
      unreadCount: json['unreadCount'] ?? 0,
      members: (json['members'] as List<dynamic>?)
              ?.map((e) => ChatRoomMember.fromJson(e))
              .toList() ?? [],
    );
  }
}
