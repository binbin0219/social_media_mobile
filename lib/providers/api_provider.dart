import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_mobile/api/api_client.dart';

final apiProvider = FutureProvider<ApiClient>((ref) async {
  return await ApiClient.create();
});