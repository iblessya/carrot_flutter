import 'package:carrot_flutter/src/shared/global.dart';
import 'user_model.dart';

class CommunityModel {
  late int id;
  late int userId;
  int? imageId;
  late String category;
  late String title;
  late String content;
  DateTime? createdAt;
  bool isMe = false;
  UserModel? writer;

  get imageUrl => (imageId != null) ? "${Global.baseUrl}/file/$imageId" : null;

  CommunityModel({
    required this.id,
    required this.userId,
    required this.isMe,
    this.imageId,
    required this.title,
    required this.category,
    required this.content,
    this.writer,
    this.createdAt,
  });

  CommunityModel.parse(Map<String, dynamic> m) {
    id = m['id'];
    userId = m['user_id'];
    imageId = m['image_id'];
    category = m['category'];
    title = m['title'];
    content = m['content'];
    createdAt =
    m['created_at'] != null ? DateTime.parse(m['created_at']) : null;
    writer = m['writer'] != null ? UserModel.parse(m['writer']) : null;
  }

  CommunityModel copyWith({
    int? id,
    int? userId,
    String? category,
    String? content,
    String? title,
    int? imageId,
    bool? isMe,
    UserModel? writer,
    DateTime? createdAt,
  }) {
    return CommunityModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      category: category ?? this.category,
      title: title ?? this.title,
      content: content ?? this.content,
      imageId: imageId ?? this.imageId,
      isMe: isMe ?? this.isMe,
      writer: writer ?? this.writer,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
