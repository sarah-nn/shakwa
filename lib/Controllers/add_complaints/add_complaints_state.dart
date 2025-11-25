part of 'add_complaints_cubit.dart';

sealed class AddComplaintsState {}

final class AddComplaintsInitial extends AddComplaintsState {}

final class AddComplaintsLoading extends AddComplaintsState {}

final class AddComplaintsSuccess extends AddComplaintsState {}

final class AddComplaintsFailed extends AddComplaintsState {
  final String errMessage;

  AddComplaintsFailed({required this.errMessage});
}
