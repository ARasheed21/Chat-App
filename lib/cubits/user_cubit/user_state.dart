part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UsersSuccess extends UserState {
  final List<UserModel> users;
  UsersSuccess(this.users);
}

class UsersLoading extends UserState {}

class UsersError extends UserState {
  final String message;
  UsersError(this.message);
}
