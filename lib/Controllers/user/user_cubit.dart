import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shakwa/Core/Constants/end_points.dart';
import 'package:shakwa/Core/Network/Api/dio_consumer.dart';
import 'package:shakwa/Data/Models/user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final DioConsumer dio;
  UserCubit(this.dio) : super(UserInitial());

  Future<void> getUserProfile() async {
    emit(UserLoading());
    try {
      final response = await dio.get(EndPoints.profile);
      final user = UserModel.fromJson(response);
      emit(UserSuccess(user));
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }
}
