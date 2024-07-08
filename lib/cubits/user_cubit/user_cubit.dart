import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:my_chat_app/models/user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  List<UserModel> listOfUsers = [];

  void getUsers() async {
    try {
      emit(UsersLoading());

      final users = await FirebaseFirestore.instance
          .collection('users')
          .get();

      listOfUsers.clear();

      for (final user in users.docs) {
        final userModel = UserModel.fromJson(user.data());
        if(userModel.id != FirebaseAuth.instance.currentUser!.email){
          listOfUsers.add(userModel);
        }else{
          print(userModel.id);
        }
      }

      emit(UsersSuccess(listOfUsers));

    } catch (e) {
      emit(UsersError(e.toString()));
      print(e.toString());
    }
  }

  void filterUsers(String query) {
    if (query.isEmpty) {
      emit(UsersSuccess(listOfUsers));
    } else {
      final filteredUsers = listOfUsers.where((user) => user.username.toLowerCase().contains(query.toLowerCase())).toList();
      emit(UsersSuccess(filteredUsers));
    }
  }
}
