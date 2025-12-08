part of 'complaint_details_cubit.dart';

@immutable
abstract class ComplaintDetailsState {}

class ComplaintDetailsInitial extends ComplaintDetailsState {}

final class ComplaintDetailsLoading extends ComplaintDetailsState {}

final class ComplaintDetailsSuccess extends ComplaintDetailsState {
  final ComplaintDetailsModel complaintDetailsModel;

  ComplaintDetailsSuccess({required this.complaintDetailsModel});
}

final class ComplaintDetailsFailure extends ComplaintDetailsState {
  final String errMsg;
  ComplaintDetailsFailure({required this.errMsg});
}

class ComplaintRepliesUpdated extends ComplaintDetailsState {
  final List<Comment> replies;
  ComplaintRepliesUpdated({required this.replies});
}
