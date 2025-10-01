import 'package:social_media_mobile/main.dart';
import 'package:social_media_mobile/models/chat_room.dart';
import 'package:social_media_mobile/models/chat_room_member.dart';

Future<List<ChatRoom>> fetchChatRooms(int offset) async {
  final response = await api.call(
    "GET",
    "/api/chatroom/get?offset=$offset&recordPerPage=10"
  );

  if(response.statusCode != 200) {
    throw Exception("Failed to fetch chat rooms");
  }

  final chatRooms = response.data['chatRooms'] as List;

  return chatRooms.map((chatRoom) => ChatRoom.fromJson(chatRoom)).toList();
}

ChatRoomMember findTargetUserFromPrivateRoomMembers(List<ChatRoomMember> privateRoomMembers, int currentUserId) {
  return privateRoomMembers
      .firstWhere((member) => member.userId != currentUserId);
}