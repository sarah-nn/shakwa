part of 'complaint_cubit.dart';

@immutable
abstract class ComplaintState {}

class ComplaintInitial extends ComplaintState {}


final class ComplaintLoading extends ComplaintState {}

final class ComplaintSuccess extends ComplaintState {
  final List<ComplaintModel> complaintModel;

  ComplaintSuccess({required this.complaintModel});
}

final class CompliantFailure extends ComplaintState {
  final String errMsg;
  CompliantFailure({required this.errMsg});
}

