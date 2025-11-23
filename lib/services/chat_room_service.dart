import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_mobile/main.dart';
import 'package:social_media_mobile/models/chat_message.dart';
import 'package:social_media_mobile/models/chat_room.dart';
import 'package:social_media_mobile/models/chat_room_member.dart';
import 'package:social_media_mobile/providers/websocket_client_provider.dart';

Future<List<ChatRoom>> fetchChatRooms(int offset, int recordPerPage) async {
  final response = await api.call(
    "GET",
    "/api/chatroom/get?offset=$offset&recordPerPage=$recordPerPage"
  );

  if(response.statusCode != 200) {
    throw Exception("Failed to fetch chat rooms");
  }

  final chatRooms = response.data['chatRooms'] as List;

  return chatRooms.map((chatRoom) => ChatRoom.fromJson(chatRoom)).toList();
}

Future<List<ChatMessage>> fetchChatMessages(String crmId, int offset, int recordPerPage) async {
  final response = await api.call(
    'GET',
    "/api/chatmessage/get?chatRoomId=$crmId&offset=$offset&recordPerPage=$recordPerPage"
  );

  if(response.statusCode != 200) {
    throw Exception("Failed to fetch chat rooms");
  }

  final chatMessages = response.data['chatMessages'] as List;

  return chatMessages.map((chatRoom) => ChatMessage.fromJson(chatRoom)).toList();
}

ChatRoomMember findTargetUserFromPrivateRoomMembers(List<ChatRoomMember> privateRoomMembers, int currentUserId) {
  return privateRoomMembers
      .firstWhere((member) => member.userId != currentUserId);
}

WebsocketSendResult sendMsg(WidgetRef ref, String msg, int peerId) {
  return ref.read(websocketClientProvider.notifier).send((ws) {
    ws.send(
      destination: "/app/chat.sendPrivateMessage",
      body: jsonEncode({
        "peerId": peerId,
        "text": msg,
      }),
    );
  });
}