import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_mobile/models/currentUser.dart';

class CurrentUserNotifier extends Notifier<CurrentUser?> {
  @override
  CurrentUser? build() => null;

  void setUser(CurrentUser user) {
    state = user;
  }

  void updateUnreadMessages(int count) {
    if (state == null) return;
    state = state!.copyWith(unreadChatMessageCount: count);
  }

  void incrementUnreadMessages() {
    if (state == null) return;
    state = state!.copyWith(
      unreadChatMessageCount: state!.unreadChatMessageCount + 1,
    );
  }

  void decrementUnreadMessages(count) {
    if (state == null) return;
    state = state!.copyWith(
      unreadChatMessageCount: max(state!.unreadChatMessageCount - count, 0).toInt(),
    );
  }
}

final currentUserProvider =
  NotifierProvider<CurrentUserNotifier, CurrentUser?>(() {
    return CurrentUserNotifier();
  });