import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'verify_code_state.dart';

class VerifyCodeCubit extends Cubit<VerifyCodeState> {
  VerifyCodeCubit() : super(VerifyCodeInitial());
}
