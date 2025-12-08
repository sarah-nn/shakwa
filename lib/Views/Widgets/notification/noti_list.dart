import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shakwa/Views/Widgets/notification/notifiaction_card.dart';
import 'package:shakwa/dummy_data.dart';

class NotiList extends StatelessWidget {
  const NotiList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10), // مسافة بادئة من الأعلى
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return NotificationCard(item: notifications[index]);
      },
    );
  }
}
