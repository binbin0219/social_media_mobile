import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_mobile/models/chat_room.dart';
import 'package:social_media_mobile/providers/current_user_provider.dart';
import 'package:social_media_mobile/services/chat_room_service.dart';
import 'package:social_media_mobile/utils/utils.dart';
import 'package:social_media_mobile/widgets/SmartImage.dart';
import 'package:social_media_mobile/widgets/unread_badge.dart';
import 'package:social_media_mobile/widgets/user_avatar.dart';

class ChatList extends ConsumerStatefulWidget {
  const ChatList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ChatListState();
}

class ChatListState extends ConsumerState<ChatList> {
  final List<ChatRoom> _chatRooms = [];
  
  @override
  void initState() {
    super.initState();
    fetchChatRooms(_chatRooms.length)
    .then((chatRooms) => {
      setState(() {
        _chatRooms.addAll(chatRooms);
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(16),
      itemCount: _chatRooms.length,
      separatorBuilder: (context, index) => const SizedBox(height: 25,),
      itemBuilder: (context, index) {
        final ChatRoom chatRoom = _chatRooms[index];
        final currentUser = ref.watch(currentUserProvider);
        final targetUser = findTargetUserFromPrivateRoomMembers(chatRoom.members, currentUser!.id);
        
        return InkWell(
          child: SizedBox(
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                UserAvatar(
                  userId: targetUser.userId,
                  height: 45,
                  width: 45,
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        targetUser.username,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        ),
                      ),
                      Text(
                        chatRoom.messagePreview ?? "Start chating",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[500],
                        ),
                      )
                    ],
                  )
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      formatTime(chatRoom.lastMessageAt),
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                    UnreadBadge(count: chatRoom.unreadCount),
                  ],
                ),
              ],
            ),
          )
        );
      }
    );
  }
}