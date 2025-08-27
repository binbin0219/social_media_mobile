import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';

class ApiClient {
  late Dio dio;
  late PersistCookieJar cookieJar;

  ApiClient._internal() {
    dio = Dio(BaseOptions(
      baseUrl: dotenv.env['BACK_END'] ?? '',
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10)
    ));
  }

  static Future<ApiClient> create() async { 
    final client = ApiClient._internal();
    final dir = await getApplicationDocumentsDirectory();
    client.cookieJar = PersistCookieJar(storage: FileStorage("${dir.path}/.cookies"));
    client.dio.interceptors.add(CookieManager(client.cookieJar));
    return client;
  }

  Future<Response> call(String method, String path, {Map<String, dynamic>? data}) async {
    switch(method.toUpperCase()) {
      case "GET":
        return dio.get(path);

      case "POST":
        return dio.post(path, data: data);

      default:
        throw Exception("Unsupported method: $method");
    }
  }
}