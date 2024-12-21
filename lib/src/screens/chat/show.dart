import 'package:carrot_flutter/src/widgets/listitems/chat_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/chat_controller.dart';

class ChatShow extends StatefulWidget {
  final int roomId;
  const ChatShow(this.roomId, {super.key});

  @override
  State<ChatShow> createState() => _ChatShowState();
}

class _ChatShowState extends State<ChatShow> {
  final ChatController chatController = Get.put(ChatController());
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    chatController.scrollController = _scrollController; // ScrollController 설정
    chatController.enterRoom(widget.roomId);
  }

  @override
  void dispose() {
    chatController.disconnect();
    _textEditingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final message = _textEditingController.text;
    if (message.isNotEmpty) {
      chatController.sendMessage(widget.roomId, message);
      _textEditingController.clear();
      chatController.scrollToBottom(); // 메시지 전송 후 스크롤 아래로 내리기
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('채팅'),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (chatController.chatList.isEmpty) {
                return const Center(
                  child: Text(
                    '채팅이 없습니다.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              } else {
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: chatController.chatList.length,
                  itemBuilder: (context, index) {
                    return ChatListItem(chatController.chatList[index]);
                  },
                );
              }
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.normal),
                    decoration: InputDecoration(
                      hintText: '메시지 보내기',
                      filled: true,
                      fillColor: Colors.grey.shade300, // 배경 없애기
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none, // 테두리 없애기
                        borderRadius: BorderRadius.circular(10), // 둥근 반경 주기
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                    ),
                    onSubmitted: (value) {
                      _sendMessage();
                    },
                  ),
                ),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
