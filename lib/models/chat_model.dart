import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:my_chat_app/models/user_model.dart';


class ChatModel {
  final String lastMessage;
  final String lastMessageTime;
  final UserModel user; // reciever user
  final String chatId;
  ChatModel({
    required this.lastMessage,
    required this.lastMessageTime,
    required this.user,
    required this.chatId,
  });

  factory ChatModel.fromJson(jsonData, UserModel user, String chatId) {
    return ChatModel(
      lastMessage: jsonData['lastMessage'],
      lastMessageTime: formatTimestamp(jsonData['lastMessageTime']),
      user: user,
      chatId: chatId,
    );
  }

}

String formatTimestamp(Timestamp timestamp) {
  DateTime now = DateTime.now();
  DateTime dateTime = timestamp.toDate();

  Duration difference = now.difference(dateTime);

  if (difference.inHours < 24) {
    return DateFormat.Hm().format(dateTime); // Format: hour:minutes
  } else if (difference.inHours >= 24 && difference.inHours < 48) {
    return 'Yesterday';
  } else if (difference.inHours >= 48 && difference.inDays < 7) {
    return DateFormat.E().format(dateTime); // Format: day of the week
  } else {
    return DateFormat('dd/MM/yyyy').format(dateTime); // Format: day/month/year
  }
}
