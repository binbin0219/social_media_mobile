import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:social_media_mobile/models/has_id.dart';

String getUserAvatarUrl(int? userId) {
  print(userId);
  return "${dotenv.env['R2_PUBLIC_URL']}/user/$userId/avatar/avatar.png";
}

String formatToTime(DateTime date) {
  int hour = date.hour;
  int minute = date.minute;

  String period = hour >= 12 ? 'PM' : 'AM';

  hour = hour % 12;
  if (hour == 0) hour = 12;

  String minuteStr = minute.toString().padLeft(2, '0');

  return '$hour:$minuteStr $period';
}

List<T> mergeItemsWithUniqueId<T extends HasId>(List<T> items1, List<T> items2) {
  Set<dynamic> existingDataIds = items1.map((data) => data.id).toSet();
  List<T> newData = items2.where((data) => !existingDataIds.contains(data.id)).toList();

  return [...items1, ...newData];
}
