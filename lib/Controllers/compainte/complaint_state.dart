part of 'complaint_cubit.dart';

@immutable
abstract class ComplaintState {}

class ComplaintInitial extends ComplaintState {}

final class ComplaintLoading extends ComplaintState {}

class ComplaintPaginationLoading extends ComplaintState {
  final List<ComplaintModel> oldComplaints;

  ComplaintPaginationLoading(this.oldComplaints);
}

class ComplaintSuccess extends ComplaintState {
  final List<ComplaintModel> allComplaints;
  final int currentPage;
  final bool hasMore;

  ComplaintSuccess({
    required this.allComplaints,
    required this.currentPage,
    required this.hasMore,
  });
}

final class CompliantFailure extends ComplaintState {
  final String errMsg;
  CompliantFailure({required this.errMsg});
}
