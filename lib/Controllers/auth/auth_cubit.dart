import 'package:flutter/material.dart';
import 'package:shakwa/Core/cache_helper.dart';
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
    final fcm = await CacheHelper.getSecureData(key: "fcm");
    emit(AuthLoading());
    final result = await authRepo.signUp({
      'full_name': fullname.text,
      'email': email.text,
      'password': password.text,
      'fcm_token': fcm,
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
    final fcm = await CacheHelper.getSecureData(key: "fcm");
    print(fcm);
    emit(AuthLoading());
    final result = await authRepo.signIn({
      'email': email.text,
      'password': password.text,
      'fcm_token': fcm,
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

  verify(String email, String code) async {
    emit(AuthLoading());
    final result = await authRepo.verify({'email': email, 'otp': code});
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
