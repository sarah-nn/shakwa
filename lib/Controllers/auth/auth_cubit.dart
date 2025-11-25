import 'package:flutter/material.dart';
import 'package:shakwa/Data/Repos/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepo}) : super(AuthInitial());

  final AuthRepo authRepo;

  static AuthCubit get(BuildContext context) => BlocProvider.of(context);

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController rePassword = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController fullname = TextEditingController();

  signUp() async {
    emit(AuthLoading());
    final result = await authRepo.signUp({
      'full_name': fullname.text,
      'email': email.text,
      'password': password.text,
    });
    result.fold(
      (failure) {
        emit(AuthFail(errMssg: failure.errorMessage));
      },
      (success) {
        emit(AuthSuccess());
      },
    );
  }

  signIn() async {
    emit(AuthLoading());
    final result = await authRepo.signIn({
      'email': email.text,
      'password': password.text,
    });
    result.fold(
      (failure) {
        emit(AuthFail(errMssg: failure.errorMessage));
      },
      (success) {
        emit(AuthSuccess());
      },
    );
  }
}
