part of 'complaint_type_cubit.dart';

sealed class ComplaintTypeState {}

final class ComplaintTypeInitial extends ComplaintTypeState {}

final class ComplaintTypeLoading extends ComplaintTypeState {}

final class ComplaintTypeLoaded extends ComplaintTypeState {
  final ComplaintTypeResponse model;

  ComplaintTypeLoaded({required this.model});
}

final class ComplaintTypeFail extends ComplaintTypeState {
  final String errMessage;

  ComplaintTypeFail({required this.errMessage});
}
