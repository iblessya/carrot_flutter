import 'dart:convert';

import 'package:carrot_flutter/src/shared/global.dart';
import 'package:get_storage/get_storage.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'provider.dart';

class ChatProvider extends Provider {
  Future<Map> roomIndex(int page) async {
    final response = await get('/api/chat/room', query: {'page': '$page'});
    return response.body;
  }

  Future<Map> createRoom(int feed) async {
    final response = await post('/api/chat/room', {
      'feedId': '$feed',
    });
    return response.body;
  }

  Future<Map> loadMessages(int roomId) async {
    final response = await get('/api/chat/room/$roomId');
    return response.body;
  }
}

class SocketProvider {
  final box = GetStorage();
  WebSocketChannel? _channel;

  Stream get messages => _channel?.stream ?? const Stream.empty();

  void connect() {
    _channel = IOWebSocketChannel.connect(Global.chatUrl);
  }

  void sendMessage(int roomId, String content) {
    final message = jsonEncode({
      'token': box.read('access_token'),
      'roomId': '$roomId',
      'content': content,
    });
    _channel?.sink.add(message);
  }

  void disconnect() {
    _channel?.sink.close();
  }
}
