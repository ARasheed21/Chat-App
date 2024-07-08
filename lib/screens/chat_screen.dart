import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_chat_app/cubits/add_message_cubit/add_message_cubit.dart';
import 'package:my_chat_app/cubits/get_message_cubit/get_message_cubit.dart';
import 'package:my_chat_app/widgets/chat_bubble.dart';
import 'package:my_chat_app/widgets/message_bar.dart';

import '../cubits/chat_cubit/chat_cubit.dart';
import '../models/user_model.dart';
import '../utils/app_colors.dart';
import '../widgets/favourite_icon.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, required this.user, required this.chatId});

  TextEditingController controller = TextEditingController();
  final scrollController = ScrollController();
  final UserModel user;
  final String chatId;

  void scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          //elevation: 0,
          leadingWidth: 30,
          title: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                backgroundImage:
                    user.photoUrl != null ? NetworkImage(user.photoUrl!) : null,
                child: user.photoUrl == null
                    ? Icon(
                        Icons.person_rounded,
                        size: 30,
                        color: AppColors.primary,
                      )
                    : null,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                user.username,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: 'Roboto',
                ),
              ),
            ],
          ),
        ),
        backgroundColor: AppColors.primary,
        body: BlocProvider(
          create: (context) => GetMessageCubit(chatId)..getStreamChat(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<GetMessageCubit, GetMessageState>(
                    builder: (context, state) {
                      if (state is GetMessageLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is GetMessageError) {
                        return Center(
                          child: Text(state.error),
                        );
                      } else if (state is GetMessageSuccess) {
                        final messages = state.messages;
                        if (messages.isEmpty) {
                          return Center(
                              child: Text(
                            "No Messages Yet",
                            style: TextStyle(color: Colors.white),
                          ));
                        }
                        return ListView.builder(
                          controller: scrollController,
                          itemCount: messages.length,
                          itemBuilder: (context, i) {
                            final message = messages[i];
                            return message.senderId ==
                                    FirebaseAuth.instance.currentUser!.email!
                                ? ChatBubble(message: message.content)
                                : FriendChatBubble(message: message.content);
                          },
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                ),
                MessageBar(
                  controller: controller,
                  hintText: 'write',
                  onTab: () {
                    context.read<AddMessageCubit>().addMessage(
                        context: context,
                        chatId: chatId,
                        user: user,
                        content: controller.text);
                    controller.clear();
                    scrollController.animateTo(0,
                        duration: Duration(milliseconds: 100),
                        curve: Curves.easeIn);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
