import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shakwa/Controllers/notification/notification_cubit.dart';
import 'package:shakwa/Data/Models/noti_model.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الإشعارات')),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is NotificationsError) {
            return Center(child: Text(state.message));
          }

          if (state is NotificationsLoaded) {
            if (state.notifications.isEmpty) {
              return const Center(child: Text('لا يوجد إشعارات'));
            }

            return ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: state.notifications.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                return _NotificationItem(
                  notification: state.notifications[index],
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final NotificationModel notification;

  const _NotificationItem({required this.notification});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat(
      'yyyy/MM/dd – HH:mm',
    ).format(notification.createdAt);

    return Card(
      elevation: 2,
      child: ListTile(
        leading: const Icon(Icons.notifications),
        title: Text(
          notification.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(notification.body),
            const SizedBox(height: 6),
            Text(
              date,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
