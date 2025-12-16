import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shakwa/Data/Models/noti_model.dart';
import 'package:shakwa/Data/Repos/noti_repo.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.service) : super(NotificationInitial());

  final NotiRepo service;

  Future<void> fetchNotifications() async {
    emit(NotificationsLoading());

    try {
      final notifications = await service.getAllNotifications();
      emit(NotificationsLoaded(notifications));
    } catch (e) {
      emit(NotificationsError('فشل في تحميل الإشعارات'));
    }
  }
}
