import 'package:carrot_flutter/src/shared/global.dart';
import 'user_model.dart';

class FeedModel {
  late int id;
  late String title;
  int? imageId;
  bool isMe = false;
  bool isFavorite = false;
  late String content;
  late int price;
  DateTime? createdAt;
  UserModel? writer;
  int favoriteCount = 0;
  int chatCount = 0;

  get imageUrl => (imageId != null)
      ? "${Global.baseUrl}/file/$imageId"
      : 'https://picsum.photos/seed/picsum/640/480';

  FeedModel({
    required this.id,
    required this.title,
    required this.content,
    required this.price,
    required this.createdAt,
    required this.isMe,
    required this.isFavorite,
    this.imageId,
    this.writer,
    this.favoriteCount = 0,
    this.chatCount = 0,
  });

  FeedModel.parse(Map<String, dynamic> m) {
    id = m['id'];
    title = m['title'];
    content = m['content'];
    price = m['price'];
    imageId = m['image_id'];
    isMe = m['is_me'] ?? false;
    createdAt = DateTime.parse(m['created_at']);
    writer = (m['writer'] != null) ? UserModel.parse(m['writer']) : null;
    isFavorite = m['is_favorited'] ?? false;
    favoriteCount = m['favorite_count'] ?? 0; // favorite_count 값 파싱
    chatCount = m['chat_count'] ?? 0; // favorite_count 값 파싱
  }

  FeedModel copyWith({
    int? id,
    String? title,
    String? content,
    int? price,
    int? imageId,
    bool? isMe,
    DateTime? createdAt,
    UserModel? writer,
    bool? isFavorite,
    int? favoriteCount,
    int? chatCount,
  }) {
    return FeedModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      price: price ?? this.price,
      imageId: imageId ?? this.imageId,
      createdAt: createdAt ?? this.createdAt,
      writer: writer ?? this.writer,
      isMe: isMe ?? this.isMe,
      isFavorite: isFavorite ?? this.isFavorite,
      favoriteCount: favoriteCount ?? this.favoriteCount,
      chatCount: chatCount ?? this.chatCount,
    );
  }
}
