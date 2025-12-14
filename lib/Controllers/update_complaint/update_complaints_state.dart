part of 'update_complaints_cubit.dart';

sealed class UpdateComplaintsState {}

final class UpdateComplaintsInitial extends UpdateComplaintsState {}

final class UpdateComplaintsLoading extends UpdateComplaintsState {}

final class UpdateComplaintsSuccess extends UpdateComplaintsState {
  final String successMessage;

  UpdateComplaintsSuccess({required this.successMessage});
}

final class UpdateComplaintsFail extends UpdateComplaintsState {
  final String errMssg;

  UpdateComplaintsFail({required this.errMssg});
}
