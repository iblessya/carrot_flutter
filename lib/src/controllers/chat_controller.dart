import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/chat_model.dart';
import '../models/room_model.dart';
import '../providers/chat_provider.dart';

class ChatController extends GetxController {
  final chatProvider = Get.put(ChatProvider());
  final socketProvider = Get.put(SocketProvider());
  final RxList<RoomModel> roomList = <RoomModel>[].obs;
  final RxList<ChatModel> chatList = <ChatModel>[].obs;
  ScrollController? scrollController; // ScrollController 추가

  Future<void> roomIndex({int page = 1}) async {
    Map result = await chatProvider.roomIndex(page);
    List<RoomModel> tmp =
    result['data'].map<RoomModel>((m) => RoomModel.parse(m)).toList();
    (page == 1) ? roomList.assignAll(tmp) : roomList.addAll(tmp);
    connect();
  }

  newRoom(int feed) async {
    Map result = await chatProvider.createRoom(feed);
    return result['roomId'];
  }

  enterRoom(int room) async {
    final result = await chatProvider.loadMessages(room);
    final tmp =
    result['data'].map<ChatModel>((m) => ChatModel.parse(m)).toList();
    chatList.assignAll(tmp);
    scrollToBottom(); // 메시지 로드 후 스크롤 아래로 내리기
  }

  void sendMessage(int roomId, String content) {
    socketProvider.sendMessage(roomId, content);
  }

  void connect() {
    socketProvider.connect();
    socketProvider.messages.listen((message) {
      final chat = ChatModel.parse(json.decode(message));
      final roomIndex = roomList.indexWhere((room) => room.id == chat.roomId);
      if (roomIndex != -1) {
        chatList.add(chat);
        scrollToBottom();

        roomList[roomIndex].lastMessage = chat.content;
        roomList.refresh();
      }
    });
  }

  void disconnect() {
    socketProvider.disconnect();
  }

  void scrollToBottom() {
    if (scrollController != null && scrollController!.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        scrollController!.animateTo(
          scrollController!.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }
}
