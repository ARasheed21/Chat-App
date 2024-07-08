part of 'add_message_cubit.dart';

@immutable
abstract class AddMessageState {}

class AddMessageInitial extends AddMessageState {}

class AddMessageSuccess extends AddMessageState {
  AddMessageSuccess(){
    print('Message Sent');
  }
}

class AddMessageLoading extends AddMessageState {
  AddMessageLoading() {
    print('Message Loading');
  }
}

class UpdateChat extends AddMessageState{
  final ChatModel updatedChat;
  UpdateChat(this.updatedChat);
}

class AddMessageError extends AddMessageState {
  final String message;
  AddMessageError(this.message);
}
