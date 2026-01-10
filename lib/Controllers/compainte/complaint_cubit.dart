import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shakwa/Data/Models/complaint_model.dart';
import 'package:shakwa/Data/Repos/show_complain_repo.dart';

part 'complaint_state.dart';

class ComplaintCubit extends Cubit<ComplaintState> {
  final ShowComplaintRepo showComplaintRepo;
  ComplaintCubit({required this.showComplaintRepo}) : super(ComplaintInitial());

  static const int complaintsLimit = 10;

  Future<void> getComplaint({
    bool isInitial = false,
    bool isRefresh = false,
  }) async {
    // 1. إذا كان تحديث (Refresh)، نصفر القائمة ونبدأ من صفحة 1
    if (isInitial || isRefresh) {
      emit(ComplaintLoading()); // سيظهر مؤشر التحميل الرئيسي
      final response = await showComplaintRepo.getComplaint(
        page: 1,
        limit: complaintsLimit,
      );

      response.fold((err) => emit(CompliantFailure(errMsg: err.errorMessage)), (
        paginationModel,
      ) {
        final int totalPages =
            (paginationModel.total / paginationModel.limit).ceil();
        emit(
          ComplaintSuccess(
            allComplaints: paginationModel.complaints,
            currentPage: paginationModel.page,
            hasMore: paginationModel.page < totalPages,
          ),
        );
      });
      return;
    }

    // 2. منطق الـ Pagination العادي (لتحميل المزيد عند السكرول)
    final List<ComplaintModel> currentList =
        (state is ComplaintSuccess)
            ? (state as ComplaintSuccess).allComplaints
            : [];

    if (state is ComplaintSuccess) {
      final successState = state as ComplaintSuccess;
      if (!successState.hasMore) return;
      emit(ComplaintPaginationLoading(currentList));
    }

    int nextPage = (currentList.length / complaintsLimit).ceil() + 1;
    final response = await showComplaintRepo.getComplaint(
      page: nextPage,
      limit: complaintsLimit,
    );

    response.fold(
      (err) {
        emit(CompliantFailure(errMsg: err.errorMessage));
      },
      (paginationModel) {
        final int totalPages =
            (paginationModel.total / paginationModel.limit).ceil();

        final bool newHasMore = paginationModel.page < totalPages;

        final List<ComplaintModel> updatedList = [
          ...currentList,
          ...paginationModel.complaints,
        ];

        emit(
          ComplaintSuccess(
            allComplaints: updatedList,
            currentPage: paginationModel.page,
            hasMore: newHasMore,
          ),
        );
      },
    );
  }
}
