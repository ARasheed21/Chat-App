part of 'get_message_cubit.dart';

@immutable
abstract class GetMessageState {}

class GetMessageInitial extends GetMessageState {}

class GetMessageSuccess extends GetMessageState {
  final List <MessageModel> messages;
  GetMessageSuccess(this.messages);
}

class GetMessageLoading extends GetMessageState {}

class GetMessageError extends GetMessageState {
  final String error;
  GetMessageError(this.error);
}
