import 'package:social_media_mobile/models/chat_room.dart';

List<ChatRoom> sortChatRooms(List<ChatRoom> chatRooms) {
  final sorted = [...chatRooms];
  sorted.sort((a, b) => b.lastMessageAt.compareTo(a.lastMessageAt));
  return sorted;
}