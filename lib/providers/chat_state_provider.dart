import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_mobile/models/chat_message.dart';
import 'package:social_media_mobile/models/chat_room.dart';
import 'package:social_media_mobile/models/currentUser.dart';
import 'package:social_media_mobile/providers/current_user_provider.dart';
import 'package:social_media_mobile/utils/chat.dart';
import 'package:social_media_mobile/utils/utils.dart';

class ChatState {
  String? activeChatRoomId;
  List<ChatRoom> chatRooms;

  ChatState({
    this.activeChatRoomId,
    List<ChatRoom>? chatRooms
  }) : chatRooms = chatRooms != null ? sortChatRooms(chatRooms) : [];

  ChatState copyWith({
    String? activeChatRoomId,
    List<ChatRoom>? chatRooms
  }) {
    return ChatState(
      activeChatRoomId: activeChatRoomId ?? this.activeChatRoomId,
      chatRooms: chatRooms ?? this.chatRooms
    );
  }
}

class ChatStateProvider extends Notifier<ChatState> {
  @override
  ChatState build() {
    return ChatState();
  }

  void setActiveChatRoomId(String chatRoomId) {
    state = state.copyWith(activeChatRoomId: chatRoomId);
  }

  void clearActiveChatRoomId() {
    state.activeChatRoomId = null;
    state = state.copyWith();
  }

  int clearUnreadCount(String chatRoomId) {
    final chatRoomIndex = state.chatRooms.indexWhere((cr) => cr.id == chatRoomId);
    if(chatRoomIndex == -1) return 0;

    final clearedCount = state.chatRooms[chatRoomIndex].unreadCount;
    state.chatRooms[chatRoomIndex].unreadCount = 0;
    state = state.copyWith();
    return clearedCount;
  }

  void addChatRooms(List<ChatRoom> chatRooms) {
    state.chatRooms= mergeItemsWithUniqueId(
      chatRooms, 
      state.chatRooms
    );
    state.chatRooms = sortChatRooms(state.chatRooms);
    state = state.copyWith();
  }

  void addMessages(List<ChatMessage> messages, String chatRoomId) {
    final chatRoomIndex = state.chatRooms.indexWhere((cr) => cr.id == chatRoomId);
    if(chatRoomIndex == -1) return;

    state.chatRooms[chatRoomIndex].messages = mergeItemsWithUniqueId(
      state.chatRooms[chatRoomIndex].messages,
      messages
    );
    state = state.copyWith();
  }

  void handleWsPrivateMsg(frame) {
    final Map<String, dynamic> body = jsonDecode(frame.body!);
    final String chatRoomId = body['chatRoomId'];
    final bool isActive = state.activeChatRoomId == chatRoomId;

    final updatedChatRooms = state.chatRooms.map((cr) {
      // TODO: Currently only work if chatroom found, if not found have to find a solution
      if (cr.id != chatRoomId) return cr;

      ChatRoom newCr = cr.copyWith(
        messages: [
          ChatMessage.fromJson(body['message']),
          ...cr.messages
        ],
        lastMessageAt: DateTime.parse(body['lastMessageAt']),
        messagePreview: body['messagePreview'],
      );

      if(!isActive) {
        newCr.unreadCount++;
        ref.read(currentUserProvider.notifier).incrementUnreadMessages();
      }

      return newCr;
    }).toList();

    state = state.copyWith(chatRooms: updatedChatRooms);
  }

}

final chatStateProvider = NotifierProvider<ChatStateProvider, ChatState>(() => ChatStateProvider());