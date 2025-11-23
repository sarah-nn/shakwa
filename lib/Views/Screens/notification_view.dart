import 'package:flutter/material.dart';
import 'package:shakwa/Core/Constants/app_color.dart';
import 'package:shakwa/Views/Widgets/normal_appBar.dart';
import 'package:shakwa/Views/Widgets/noti_list.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppBar(text: 'الإشعارات',),
      body: NotiList(),
      backgroundColor: AppColor.secondColor,
    );
  }
}
