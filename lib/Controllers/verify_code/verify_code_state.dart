part of 'verify_code_cubit.dart';

sealed class VerifyCodeState {}

final class VerifyCodeInitial extends VerifyCodeState {}

final class VerifyCodeLoading extends VerifyCodeState {}

final class VerifyCodeDone extends VerifyCodeState {}

final class VerifyCodeFail extends VerifyCodeState {
  final String errMessage;

  VerifyCodeFail({required this.errMessage});
}
