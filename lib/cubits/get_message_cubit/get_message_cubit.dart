import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import '../../models/message_model.dart';
part 'get_message_state.dart';

class GetMessageCubit extends Cubit<GetMessageState> {
  GetMessageCubit(this.chatId) : super(GetMessageInitial());

  @override
  void emit(GetMessageState state){
    if(!isClosed){
      super.emit(state);
    }
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String chatId;

  void getStreamChat() {
    emit(GetMessageLoading());
    try {
      _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .orderBy('createdAt')
          .snapshots()
          .listen((snapshot) {
        final messages = snapshot.docs
            .map((doc) => MessageModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
        emit(GetMessageSuccess(messages));
      });
    } catch (e) {
      emit(GetMessageError("Failed to load messages: ${e.toString()}"));
    }
  }
}
