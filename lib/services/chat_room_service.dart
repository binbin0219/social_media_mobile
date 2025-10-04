import 'package:social_media_mobile/main.dart';
import 'package:social_media_mobile/models/chat_message.dart';
import 'package:social_media_mobile/models/chat_room.dart';
import 'package:social_media_mobile/models/chat_room_member.dart';

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

Future<List<ChatMessage>> fetchChatMessages(String chatRoomId, int offset, int recordPerPage) async {
  final response = await api.call(
    'GET',
    "/api/chatmessage/get?chatRoomId=$chatRoomId&offset=$offset&recordPerPage=$recordPerPage"
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