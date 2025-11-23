import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_mobile/main.dart';
import 'package:social_media_mobile/models/chat_message.dart';
import 'package:social_media_mobile/providers/chat_state_provider.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:collection/collection.dart';

class WebsocketClientNotifier extends AsyncNotifier<WebsocketClient> {
  @override
  FutureOr<WebsocketClient> build() async {
    final url = Uri.parse(dotenv.env["BACK_END"]!); // API host
    final jwtCookieName = dotenv.env["JWT_COOKIE_NAME"]!;
    final cookies = await api.cookieJar.loadForRequest(url);
    final jwtCookie = cookies.firstWhere(
      (c) => c.name == jwtCookieName,
      orElse: () => Cookie("empty", "") // prevent crash
    );
    final jwtToken = jwtCookie.value;

    late final StompClient websocketClient;
    websocketClient = StompClient(
      config: StompConfig(
        url: '${dotenv.env["WS_BACK_END"]}/ws',
        stompConnectHeaders: {
          'Cookie': '$jwtCookieName=$jwtToken',
        },
        webSocketConnectHeaders: {
          'Cookie': '$jwtCookieName=$jwtToken',
        },
        onConnect: (_) {
          state.value?.connected = true;

          websocketClient.subscribe(
            destination: "/user/queue/notifications",
            callback: (frame) {
              print("message: ${frame.body}");
            }
          );
          
          websocketClient.subscribe(
            destination: "/user/queue/privateMessages",
            callback: ref.read(chatStateProvider.notifier).handleWsPrivateMsg
          );
        },
        onWebSocketError: (err) {
          print("Error: $err");
          state.value?.connected = false;
        },
      ),
    );

    websocketClient.activate();
    return WebsocketClient(client: websocketClient);
  }

  WebsocketSendResult send(void Function(StompClient client) callBack) {
    if(state.value?.client == null) {
      return WebsocketSendResult(
        success: false,
        msg: "Failed to send: websocket client is not ready!"
      );
    }

    if(state.value?.connected == false) {
      return WebsocketSendResult(
        success: false,
        msg: "Failed to send: websocket client is not connected!"
      );
    }

    callBack(state.value!.client);
    return WebsocketSendResult(
      success: true,
      msg: "Sent successfully!"
    );
  }
}

class WebsocketClient {
  final StompClient client;
  bool connected;

  WebsocketClient({
    required this.client,
    this.connected = false
  });
}

class WebsocketSendResult {
  final bool success;
  final String msg;

  WebsocketSendResult({
    this.success = false,
    this.msg = ""
  });
}

final websocketClientProvider = 
  AsyncNotifierProvider<WebsocketClientNotifier, WebsocketClient>(() => WebsocketClientNotifier());