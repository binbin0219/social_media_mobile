import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_mobile/models/chat_message.dart';
import 'package:social_media_mobile/services/auth_service.dart';
import 'package:social_media_mobile/utils/utils.dart';

class ChatMessageBubble extends ConsumerWidget {
  final ChatMessage message;
  
  const ChatMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = getCurrentUser(ref);
    final bool isMe = message.senderId == currentUser!.id;

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if(isMe) ...[
          Text(
            formatToTime(message.createAt),
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(width: 5),
        ],

        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          decoration: BoxDecoration(
            color: isMe ? Colors.blue[400] : Colors.grey[300],
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
              bottomLeft: isMe ? const Radius.circular(16) : const Radius.circular(0),
              bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(16),
            )
          ),
          child: Text(
            message.text
          ),
        ),

        if(!isMe) ...[
          const SizedBox(width: 5),
          Text(
            formatToTime(message.createAt),
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ],
    );
  }
}