import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:my_chat_app/models/user_model.dart';


class ChatModel {
  final String lastMessage;
  final Timestamp lastMessageTimeStamp;
  late String lastMessageTime;
  final UserModel user; // reciever user
  final String chatId;
  ChatModel({
    required this.lastMessage,
    required this.lastMessageTimeStamp,
    required this.user,
    required this.chatId,
  }){
    lastMessageTime = formatTimestamp(lastMessageTimeStamp);
  }

  factory ChatModel.fromJson(jsonData, UserModel user, String chatId) {
    return ChatModel(
      lastMessage: jsonData['lastMessage'],
      lastMessageTimeStamp: jsonData['lastMessageTime'],
      user: user,
      chatId: chatId,
    );
  }

}

String formatTimestamp(Timestamp timestamp) {
  DateTime now = DateTime.now();
  DateTime dateTime = timestamp.toDate();

  bool isSameDay = now.year == dateTime.year &&
      now.month == dateTime.month &&
      now.day == dateTime.day;

  if (isSameDay) {
    return DateFormat.Hm().format(dateTime); // Format: hour:minutes
  } else if (now.difference(dateTime).inDays == 1) {
    return 'Yesterday';
  } else if (now.difference(dateTime).inDays < 7) {
    return DateFormat.E().format(dateTime); // Format: day of the week
  } else {
    return DateFormat('dd/MM/yyyy').format(dateTime); // Format: day/month/year
  }
}
