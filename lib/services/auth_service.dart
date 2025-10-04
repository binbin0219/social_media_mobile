import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_mobile/models/currentUser.dart';
import 'package:social_media_mobile/providers/current_user_provider.dart';

CurrentUser getCurrentUser(WidgetRef ref) {
  final currentUser = ref.watch(currentUserProvider);
  return currentUser as CurrentUser;
}