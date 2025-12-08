import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shakwa/Data/Models/complaint_model.dart';
import 'package:shakwa/Data/Repos/show_complain_repo.dart';

part 'complaint_state.dart';

class ComplaintCubit extends Cubit<ComplaintState> {
  final ShowComplaintRepo showComplaintRepo;
  ComplaintCubit({required this.showComplaintRepo}) : super(ComplaintInitial());

  static const int complaintsLimit = 10;

  Future<void> getComplaint({bool isInitial = false}) async {
    final List<ComplaintModel> currentList =
        (state is ComplaintSuccess)
            ? (state as ComplaintSuccess).allComplaints
            : [];

    int nextPage = (currentList.length / complaintsLimit).ceil() + 1;

    // حالات التحميل
    if (isInitial) {
      emit(ComplaintLoading());
    } else if (state is ComplaintSuccess) {
      final successState = state as ComplaintSuccess;
      if (!successState.hasMore) return;

      emit(ComplaintPaginationLoading(currentList));
    } else {
      emit(ComplaintLoading());
    }

    final response = await showComplaintRepo.getComplaint(
      page: nextPage,
      limit: complaintsLimit,
    );

    if (isClosed) return;

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

// class ComplaintCubit extends Cubit<ComplaintState> {
//   final ShowComplaintRepo showComplaintRepo;
//   ComplaintCubit({required this.showComplaintRepo}) : super(ComplaintInitial());

//   static const int complaintsLimit = 10;

//   Future<void> getComplaint({bool isInitial = false}) async {
//     if (isInitial) {
//       emit(ComplaintLoading());
//     } else if (state is ComplaintSuccess) {
//       final currentState = state as ComplaintSuccess;

//       if (!currentState.hasMore) return;
//       emit(ComplaintPaginationLoading());
//     } else {
//       emit(ComplaintLoading());
//     }

//     final List<ComplaintModel> currentList =
//         (state is ComplaintSuccess)
//             ? (state as ComplaintSuccess).allComplaints
//             : [];

//     int nextPage = (currentList.length / complaintsLimit).ceil() + 1;
//     if (isInitial) {
//       nextPage = 1;
//     } else if (state is ComplaintSuccess) {
//       nextPage = (state as ComplaintSuccess).currentPage + 1;
//     }

//     final response = await showComplaintRepo.getComplaint(
//       page: nextPage,
//       limit: complaintsLimit,
//     );
//     if (isClosed) {
//       return;
//     }
//     response.fold(
//       (err) {
//         if (isInitial) {
//           emit(CompliantFailure(errMsg: err.errorMessage));
//         } else if (state is ComplaintSuccess) {
//           emit(state as ComplaintSuccess);
//         }
//       },
//       (paginationModel) {
//         final int totalPages =
//             (paginationModel.total / paginationModel.limit).ceil();
//         final bool newHasMore = paginationModel.page < totalPages;

//         final List<ComplaintModel> updatedList = [];
//         updatedList.addAll(currentList);
//         updatedList.addAll(paginationModel.complaints);

//         emit(
//           ComplaintSuccess(
//             allComplaints: updatedList,
//             currentPage: paginationModel.page,
//             hasMore: newHasMore,
//           ),
//         );
//       },
//     );
//   }
// }
