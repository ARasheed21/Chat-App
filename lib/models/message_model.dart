import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String content;
  final String senderId;
  final Timestamp createdAt;
  MessageModel(
      {required this.content, required this.senderId, required this.createdAt});

  factory MessageModel.fromJson(jsonData) {
    return MessageModel(
        content: jsonData['content'],
        senderId: jsonData['senderId'],
        createdAt: jsonData['createdAt']);
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'senderId': senderId,
      'createdAt':createdAt
    };
  }
}
