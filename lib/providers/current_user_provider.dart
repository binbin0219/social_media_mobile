import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_mobile/models/currentUser.dart';

final currentUserProvider = StateProvider<CurrentUser?>((ref) => null);