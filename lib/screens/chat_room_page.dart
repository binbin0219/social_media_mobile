import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_mobile/models/chat_message.dart';
import 'package:social_media_mobile/models/chat_room.dart';
import 'package:social_media_mobile/services/auth_service.dart';
import 'package:social_media_mobile/services/chat_room_service.dart';
import 'package:social_media_mobile/widgets/chat_message_bubble.dart';
import 'package:social_media_mobile/widgets/chat_message_input.dart';
import 'package:social_media_mobile/widgets/inifinite_scroll_list.dart';
import 'package:social_media_mobile/widgets/user_avatar.dart';

class ChatRoomPage extends ConsumerStatefulWidget {
  final ChatRoom chatRoom;

  const ChatRoomPage({super.key, required this.chatRoom});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ChatRoomPageState();
}

class ChatRoomPageState extends ConsumerState<ChatRoomPage> {
  final int _recordPerPage = 20;

  @override
  void initState() {
    super.initState();
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    final targetUser = findTargetUserFromPrivateRoomMembers(widget.chatRoom.members, getCurrentUser(ref).id);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            UserAvatar(
              userId: targetUser.userId,
              width: 40,
              height: 40,
            ),

            const SizedBox(width: 10),

            Text(
              targetUser.username,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
            )
          ],
        ),

        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsetsGeometry.only(
                top: 0,
                left: 24,
                right: 24,
                bottom: 0
              ),
              child: InifiniteScrollList<ChatMessage>(
                reverse: true,
                recordPerPage: _recordPerPage, 
                itemBuilder: (chatMessage, index, chatMessages) {
                  bool isLast = index == chatMessages.length - 1;
                  bool isDateChange = !isLast && !_isSameDay(chatMessage.createAt, chatMessages[index + 1].createAt);

                  if(isLast || isDateChange) {
                    return Column(
                      children: [
                        const SizedBox(height: 15),
                        Text(
                          "${chatMessage.createAt.day}/${chatMessage.createAt.month}/${chatMessage.createAt.year}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700]
                          ),
                        ),
                        const SizedBox(height: 25),
                        ChatMessageBubble(message: chatMessage),
                      ],
                    );
                  }

                  return ChatMessageBubble(message: chatMessage);
                }, 
                fetchData: (offset) async => await fetchChatMessages(widget.chatRoom.id, offset, _recordPerPage)
              ),
            )
          ),

          Container(
            padding: EdgeInsetsGeometry.only(
              top: 12,
              left: 12,
              right: 12,
              bottom: 24
            ),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(
                top: BorderSide(color: Colors.grey[300]!)
              )
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.emoji_emotions_outlined, color: Colors.grey),
                  onPressed: () {},
                ),

                Expanded(
                  child: ChatMessageInput(),
                ),

                Row(
                  children: [
                    IconButton(
                      onPressed: () {}, 
                      icon: Icon(Icons.attach_file, color: Colors.grey)
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[400],
                        shape: BoxShape.circle
                      ),
                      child: IconButton(
                      onPressed: () {}, 
                        icon: Icon(Icons.send, color: Colors.white)
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      )
    );
  }
}