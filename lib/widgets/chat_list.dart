import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_mobile/models/chat_room.dart';
import 'package:social_media_mobile/providers/chat_state_provider.dart';
import 'package:social_media_mobile/services/auth_service.dart';
import 'package:social_media_mobile/services/chat_room_service.dart';
import 'package:social_media_mobile/utils/utils.dart';
import 'package:social_media_mobile/widgets/inifinite_scroll_list.dart';
import 'package:social_media_mobile/widgets/unread_badge.dart';
import 'package:social_media_mobile/widgets/user_avatar.dart';

class ChatList extends ConsumerStatefulWidget {
  final int recordPerPage = 10;
  const ChatList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ChatListState();
}

class ChatListState extends ConsumerState<ChatList> {

  void handleEnterChatRoom(ChatRoom chatRoom) {
    ref.read(chatStateProvider.notifier).clearUnreadCount(chatRoom.id);
    ref.read(chatStateProvider.notifier).setActiveChatRoomId(chatRoom.id);
    Navigator.pushNamed(
      context, 
      '/chat-room',
      arguments: chatRoom
    );
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatStateProvider);

    return Padding(
      padding: EdgeInsetsGeometry.all(16),
      child: InifiniteScrollList<ChatRoom>(
        recordPerPage: widget.recordPerPage,
        data: chatState.chatRooms,
        fetchData: (offset) async {
          final chatRooms = await fetchChatRooms(offset, widget.recordPerPage);
          ref.read(chatStateProvider.notifier).addChatRooms(chatRooms);
          return chatRooms.length;
        },
        itemBuilder:(chatRoom, index, chatRooms) {
          final currentUser = getCurrentUser(ref);
          final targetUser = findTargetUserFromPrivateRoomMembers(chatRoom.members, currentUser!.id);
          
          return InkWell(
            onTap: () { handleEnterChatRoom(chatRoom); },
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
                        formatToTime(chatRoom.lastMessageAt),
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
      ),
    );
  }
}