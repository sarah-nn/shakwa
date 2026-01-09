part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final UserModel user;
  UserSuccess(this.user);
}

class UserFailure extends UserState {
  final String errMessage;
  UserFailure(this.errMessage);
}
