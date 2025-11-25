import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shakwa/Data/Models/complaint_details_model.dart';
import 'package:shakwa/Data/Repos/show_complain_repo.dart';

part 'complaint_details_state.dart';

class ComplaintDetailsCubit extends Cubit<ComplaintDetailsState> {
    final ShowComplaintRepo showComplaintRepo;

  ComplaintDetailsCubit({required this.showComplaintRepo}) : super(ComplaintDetailsInitial());

  Future<void> getComplaintDetails({required int complaint}) async {
    emit(ComplaintDetailsLoading());
    final response = await showComplaintRepo.getCompanintDetails(complaint);
    if (isClosed) {
      return;
    }
    response.fold(
      (err) => emit(ComplaintDetailsFailure(errMsg: err.errorMessage)),
      (complaint) => emit(ComplaintDetailsSuccess(complaintDetailsModel: complaint)),
    );
  }

    Future<void> sendReply({required int complaintId, required String text}) async {
    try {
      emit(ComplaintDetailsLoading());

      // استدعاء API لإرسال الرد
      await showComplaintRepo.sendReply(
        complaintId: complaintId,
        text: text,
      );

      // بعد النجاح يمكن إعادة تحميل تفاصيل الشكوى لتحديث الـ UI
      // await getComplaintDetails(complaint: complaintId);
    } catch (e) {
      emit(ComplaintDetailsFailure(errMsg: e.toString()));
    }
  }
}
