part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatSuccess extends ChatState {
  final List <ChatModel> chats;
  ChatSuccess(this.chats);
}

class ChatLoading extends ChatState {}

class ChatUpdated extends ChatState {}

class ChatError extends ChatState {
  final String error;

  ChatError(this.error);
}
