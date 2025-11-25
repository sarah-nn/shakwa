import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakwa/Data/Repos/send_complaint_repo.dart';
part 'add_complaints_state.dart';

class AddComplaintsCubit extends Cubit<AddComplaintsState> {
  AddComplaintsCubit({required this.repo}) : super(AddComplaintsInitial());

  SendComplaintRepo repo;

  // final TextEditingController location = TextEditingController();
  // final TextEditingController desc = TextEditingController();

  sendComplaint(String location, String desc, int id, String path) async {
    emit(AddComplaintsLoading());
    final result = await repo.sendComplaint({
      'location': location,
      'description': desc,
      'complaintTypeId': id,
      'files': path,
    });
    result.fold(
      (failure) {
        emit(AddComplaintsFailed(errMessage: failure.errorMessage));
      },
      (success) {
        emit(AddComplaintsSuccess());
      },
    );
  }
}
