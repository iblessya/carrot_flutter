import 'package:carrot_flutter/src/shared/timeutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/user_controller.dart';
import '../../models/chat_model.dart';

class ChatListItem extends StatelessWidget {
  final ChatModel chat;
  const ChatListItem(this.chat, {super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    bool isMe = userController.my.value?.id == chat.userId;
    return isMe ? _buildMyMessage(context) : _buildOtherMessage(context);
  }

  Widget _buildOtherMessage(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(chat.content),
        ),
        Text(
          TimeUtil.parse(chat.createdAt),
          style: const TextStyle().copyWith(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildMyMessage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          TimeUtil.parse(chat.createdAt),
          style: const TextStyle().copyWith(color: Colors.grey),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            chat.content,
            style: const TextStyle().copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
