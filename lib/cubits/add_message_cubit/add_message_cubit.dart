import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:my_chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:my_chat_app/models/chat_model.dart';

import '../../models/user_model.dart';

part 'add_message_state.dart';

class AddMessageCubit extends Cubit<AddMessageState> {
  AddMessageCubit() : super(AddMessageInitial());

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final ChatCubit chatCubit = ChatCubit();
  final TextEditingController controller = TextEditingController();

  Future<void> addMessage(
      {required BuildContext context,
      required String chatId,
      required UserModel user,
      required String content}) async {
    try {
      if (content.isNotEmpty) {
        emit(AddMessageLoading());

        Timestamp createdAt = Timestamp.now();
        var message = {
          'content': content,
          'createdAt': createdAt,
          'senderId': auth.currentUser!.email,
        };

        var messageRef = firestore
            .collection('chats')
            .doc(chatId)
            .collection('messages')
            .doc();
        await messageRef.set(message);
        var chatRef = firestore.collection('chats').doc(chatId);
        await chatRef.set({
          'lastMessage': content,
          'lastMessageTime': createdAt,
        });

        ChatModel updatedChat = ChatModel.fromJson(
          <String, dynamic>{
            'lastMessage': content,
            'lastMessageTime': createdAt,
          },
          user,
          chatId,
        );
        controller.clear();

        emit(AddMessageSuccess());
        emit(UpdateChat(updatedChat));
      } else {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Message cannot be empty'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      emit(AddMessageError(e.toString()));
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send message: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
