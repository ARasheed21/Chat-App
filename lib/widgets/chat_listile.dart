import 'package:flutter/material.dart';
import 'package:my_chat_app/models/chat_model.dart';
import 'package:my_chat_app/models/user_model.dart';
import '../screens/chat_screen.dart';
import '../utils/app_colors.dart';

class ChatLisTile extends StatelessWidget {
  ChatLisTile({super.key, required this.chat});

  final ChatModel chat;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 4),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ChatScreen(user: chat.user, chatId: chat.chatId,);
            },
          ),
        );
      },
      leading: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white,
            backgroundImage: chat.user.photoUrl != null? NetworkImage(chat.user.photoUrl!):null,
            child: chat.user.photoUrl == null ?Icon(
              Icons.person_rounded,
              size: 40,
              color: AppColors.primary,
            ):null,
          ),
          // Positioned(
          //   top: -10,
          //   left: -10,
          //   child: CounterCircleAvatar(counter: '+5',),
          // ),
        ],
      ),
      title: Text(
        chat.user.username,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontFamily: 'Roboto',
        ),
      ),
      subtitle: Text(
       chat.lastMessage,
        style: TextStyle(
          fontSize: 14,
          color: Color(0xccffffff),
        ),
      ),
      trailing: Text(
        chat.lastMessageTime,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }
}

class UserLisTile extends StatelessWidget {
  UserLisTile({super.key, required this.user, required this.chatId});

  final UserModel user;
  final String chatId;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ChatScreen(user: user, chatId: chatId,);
            },
          ),
        );
      },
      leading: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white,
            backgroundImage: user.photoUrl != null? NetworkImage(user.photoUrl!):null,
            child: user.photoUrl == null ?Icon(
              Icons.person_rounded,
              size: 40,
              color: AppColors.primary,
            ):null,
          ),
          // Positioned(
          //   top: -10,
          //   left: -10,
          //   child: CounterCircleAvatar(counter: '+5',),
          // ),
        ],
      ),
      title: Text(
        user.username,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontFamily: 'Roboto',
        ),
      ),
      subtitle: Text(
        '',
        style: TextStyle(
          fontSize: 14,
          color: Color(0xccffffff),
        ),
      ),
      trailing: Text(
        '',
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontFamily: 'Roboto',
        ),
      ),

    );
  }
}

