import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shakwa/Data/Models/complaint_model.dart';
import 'package:shakwa/Data/Repos/show_complain_repo.dart';

part 'complaint_state.dart';

class ComplaintCubit extends Cubit<ComplaintState> {
  final ShowComplaintRepo showComplaintRepo;
  ComplaintCubit({ required this.showComplaintRepo}) : super(ComplaintInitial());

  Future<void> getComplaint() async {
    emit(ComplaintLoading());
    final response = await showComplaintRepo.getComplaint();
    if (isClosed) {
      return;
    }
    response.fold(
      (err) => emit(CompliantFailure(errMsg: err.errorMessage)),
      (exam) => emit(ComplaintSuccess(complaintModel: exam)),
    );
  }
}
