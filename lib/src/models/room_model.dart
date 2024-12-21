import 'package:carrot_flutter/src/models/feed_model.dart';

import 'user_model.dart';

class RoomModel {
  late int id;
  late UserModel client;
  late FeedModel feed;
  late String title;
  late String lastMessage;
  DateTime? updatedAt;

  RoomModel({
    required this.id,
    required this.client,
    required this.feed,
    required this.title,
    required this.lastMessage,
    this.updatedAt,
  });

  RoomModel.parse(Map<String, dynamic> m) {
    id = m['id'];
    client = UserModel.parse(m['client']);
    feed = FeedModel.parse(m['feed']);
    lastMessage = m['lastMessage'];
    title = m['feed']['title'];
    updatedAt = m['updatedAt'] != null ? DateTime.parse(m['updatedAt']) : null;
  }
}
