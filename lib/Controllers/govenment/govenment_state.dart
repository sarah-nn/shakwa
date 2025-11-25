part of 'govenment_cubit.dart';

sealed class GovenmentState {}

final class GovenmentInitial extends GovenmentState {}

final class GovenmentLoading extends GovenmentState {}

final class GovenmentLoaded extends GovenmentState {
  final GovernmentModel model;

  GovenmentLoaded({required this.model});
}

final class GovenmentFetchFail extends GovenmentState {
  final String errMessage;

  GovenmentFetchFail({required this.errMessage});
}
