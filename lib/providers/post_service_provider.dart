import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_mobile/services/post_service.dart';

final postServiceProvider = Provider<PostService>((ref) {
  return PostService();
});