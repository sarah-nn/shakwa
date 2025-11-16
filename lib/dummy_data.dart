import 'package:flutter/material.dart';
import 'package:shakwa/Models/notification_model.dart';

final List<Map<String, String>> complaints = [
  {
    'type': 'بلاغ بيئي',
    'title': 'تلف رصف الشارع الرئيسي في حي الملك فهد',
    'id': 'SHQ-2024-00124',
    'status': 'تم الإنجاز',
  },
  {
    'type': 'وزارة الصحة',
    'title': 'ازدحام شديد في مركز الرعاية الأولية بحي النخيل',
    'id': 'SHQ-2024-00124',
    'status': 'قيد العمل',
  },
  {
    'type': 'هيئة الاتصالات وتقنية المعلومات',
    'title': 'ضعف تغطية الإنترنت في حي الربيع بشكل مستمر',
    'id': 'SHQ-2024-00125',
    'status': 'تم الرفع',
  },
  {
    'type': 'الشركة السعودية للكهرباء',
    'title': 'انقطاع متكرر للتيار الكهربائي في حي الياسمين',
    'id': 'SHQ-2024-00126',
    'status': 'قيد العمل',
  },
];

final List<NotificationItem> notifications = [
  NotificationItem(
    title: 'تمت مراجعة شكواك وهي الآن قيد المعالجة',
    complaintNumber: '987654321',
    date: '2023-10-26',
    icon: Icons.access_time,
    iconColor: Colors.deepOrange,
  ),
  NotificationItem(
    title: 'تم حل مشكلة شكواك وتم إغلاق الشكوى',
    complaintNumber: '123456789',
    date: '2023-10-25',
    icon: Icons.check_circle_outline,
    iconColor: Colors.blue,
  ),
  NotificationItem(
    title: 'نأسف لعدم إمكانية معالجة شكواك الحالية',
    complaintNumber: '456789012',
    date: '2023-10-24',
    icon: Icons.cancel_outlined,
    iconColor: Colors.red,
  ),
  NotificationItem(
    title: 'تم استلام شكواك ومراجعتها قريباً',
    complaintNumber: '789012345',
    date: '2023-10-23',
    icon: Icons.notifications_none,
    iconColor: Colors.grey,
  ),
];
