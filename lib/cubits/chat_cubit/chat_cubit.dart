import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:my_chat_app/services/firestore_service.dart';
import '../../models/chat_model.dart';
import '../../models/user_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  @override
  void emit(ChatState state){
    if(!isClosed){
      super.emit(state);
    }
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirestoreService _firestoreservice = FirestoreService();
  List<ChatModel> chatList = [];

  void fetchChat() {
    final currentUserEmail = FirebaseAuth.instance.currentUser!.email!;
    _firestore.collection('chats').get().then((chatsSnapshot) async {
      try {
        emit(ChatLoading());
        print('Chat Loading');

        chatList.clear(); // Clear the list to avoid duplication

        for (var doc in chatsSnapshot.docs) {
          String chatId = doc.id;
          if (chatId.contains(currentUserEmail)) {
            String email = getRecieverEmail(chatId, currentUserEmail);
            UserModel user = await _firestoreservice.getUserInfo(email);
            ChatModel chat = ChatModel.fromJson(doc.data(), user, chatId);
            chatList.add(chat);
          }
        }

        chatList.sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));
        emit(ChatSuccess(chatList));
        print('Chats Loaded Success');
      } catch (e) {
        emit(ChatError("Failed to fetch chats: ${e.toString()}"));
        print("Failed to fetch chats: ${e.toString()}");
      }
    });
  }

  void updateChat(ChatModel updatedChat) {
    try {
      bool chatExists = false;

      for (int i = 0; i < chatList.length; i++) {
        if (chatList[i].chatId == updatedChat.chatId) {
          chatList[i] = updatedChat;
          chatExists = true;
          break;
        }
      }

      if (!chatExists) {
        chatList.add(updatedChat);
      }

      chatList.sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));
      print('chat updated');
      emit(ChatSuccess(chatList));
    } catch (e) {
      print('Failed to update chat');
      emit(ChatError("Failed to update chat: $e"));
    }
  }

  Future<void> deleteChat(String chatId) async {
    try {
      await _firestoreservice.deleteChat(chatId);
      chatList.removeWhere((chat) => chat.chatId == chatId); // Refresh the user list after deletion
      emit(ChatSuccess(chatList));
      print('chat deleted');
    } catch (e) {
      emit(ChatError("Failed to delete chat: $e"));
    }
  }

  String getRecieverEmail(String chatId, String currentUserEmail) {
    List<String> emails = chatId.split('-');
    return emails[0] == currentUserEmail ? emails[1] : emails[0];
  }

}
