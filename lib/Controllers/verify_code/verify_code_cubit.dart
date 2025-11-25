import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakwa/Data/Repos/auth_repo.dart';
part 'verify_code_state.dart';

class VerifyCodeCubit extends Cubit<VerifyCodeState> {
  VerifyCodeCubit(this.repo) : super(VerifyCodeInitial());

  final AuthRepo repo;
}
