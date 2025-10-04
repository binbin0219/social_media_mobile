import 'package:social_media_mobile/models/has_id.dart';

import 'chat_attachment.dart';

class ChatMessage implements HasId {
  final String id;
  final int senderId;
  final String senderUsername;
  final String text;
  final List<ChatAttachment> attachments;
  final DateTime createAt;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.senderUsername,
    required this.text,
    required this.attachments,
    required this.createAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] ?? '',
      senderId: json['senderId'] ?? 0,
      senderUsername: json['senderUsername'] ?? '',
      text: json['text'] ?? '',
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((e) => ChatAttachment.fromJson(e))
              .toList() ??
          [],
      createAt: DateTime.parse(json['createAt']),
    );
  }
}
