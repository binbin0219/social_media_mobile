import 'package:flutter_dotenv/flutter_dotenv.dart';

String getUserAvatarUrl(int? userId) {
  return "${dotenv.env['R2_PUBLIC_URL']}/user/$userId/avatar/avatar.png";
}

String formatTime(DateTime date) {
  int hour = date.hour;
  int minute = date.minute;

  String period = hour >= 12 ? 'PM' : 'AM';

  hour = hour % 12;
  if (hour == 0) hour = 12;

  String minuteStr = minute.toString().padLeft(2, '0');

  return '$hour:$minuteStr $period';
}
