part of 'notification_cubit.dart';

@immutable
sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

class NotificationsLoading extends NotificationState {}

class NotificationsLoaded extends NotificationState {
  final List<NotificationModel> notifications;

  NotificationsLoaded(this.notifications);
}

class NotificationsError extends NotificationState {
  final String message;

  NotificationsError(this.message);
}
