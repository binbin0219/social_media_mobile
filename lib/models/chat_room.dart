import 'package:social_media_mobile/models/chat_message.dart';
import 'package:social_media_mobile/models/chat_room_member.dart';
import 'package:social_media_mobile/models/has_id.dart';

class ChatRoom implements HasId {
  final String id;
  String name;
  final String type;
  String messagePreview;
  DateTime lastMessageAt;
  int unreadCount;
  final List<ChatRoomMember> members;
  List<ChatMessage> messages;

  ChatRoom({
    required this.id,
    required this.name,
    required this.type,
    required this.messagePreview,
    required this.lastMessageAt,
    required this.unreadCount,
    required this.members,
    this.messages = const []
  });

  ChatRoom copyWith({
    String? id,
    String? name,
    String? type,
    String? messagePreview,
    DateTime? lastMessageAt,
    int? unreadCount,
    List<ChatRoomMember>? members,
    List<ChatMessage>? messages,
  }) {
    return ChatRoom(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      messagePreview: messagePreview ?? this.messagePreview,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      unreadCount: unreadCount ?? this.unreadCount,
      members: members ?? this.members,
      messages: messages ?? this.messages,
    );
  }

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
