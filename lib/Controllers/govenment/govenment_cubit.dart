import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakwa/Data/Models/government_model.dart';
import 'package:shakwa/Data/Repos/add_complaints_repo.dart';
part 'govenment_state.dart';

class GovenmentCubit extends Cubit<GovenmentState> {
  GovenmentCubit({required this.repo}) : super(GovenmentInitial());

  final AddComplaintsRepo repo;

  Future<void> getAllGovernment() async {
    emit(GovenmentLoading());
    final response = await repo.getAllGovernment();
    if (isClosed) return;
    response.fold(
      (err) => emit(GovenmentFetchFail(errMessage: err.errorMessage)),
      (governments) => emit(GovenmentLoaded(model: governments)),
    );
  }
}
