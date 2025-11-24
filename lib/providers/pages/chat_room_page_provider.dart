import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_mobile/providers/chat_state_provider.dart';

final chatRoomPageProvider = Provider.autoDispose<void>((ref) {
  final notifier = ref.read(chatStateProvider.notifier);

  // When the page closes, this runs automatically
  ref.onDispose(() {
    notifier.clearActiveChatRoomId();
  });
});
