import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakwa/Data/Models/complaints_type_model.dart';
import 'package:shakwa/Data/Repos/add_complaints_repo.dart';

part 'complaint_type_state.dart';

class ComplaintTypeCubit extends Cubit<ComplaintTypeState> {
  ComplaintTypeCubit({required this.repo}) : super(ComplaintTypeInitial());

  AddComplaintsRepo repo;

  Future<void> getCoplaintsType(String id) async {
    emit(ComplaintTypeLoading());
    final response = await repo.getComplaintType(id);
    if (isClosed) return;
    response.fold(
      (err) => emit(ComplaintTypeFail(errMessage: err.errorMessage)),
      (governments) => emit(ComplaintTypeLoaded(model: governments)),
    );
  }
}
