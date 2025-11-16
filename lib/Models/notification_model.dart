import 'package:flutter/material.dart';

class NotificationItem {
  final String title;
  final String complaintNumber;
  final String date;
  final IconData icon;
  final Color iconColor;

  NotificationItem({
    required this.title,
    required this.complaintNumber,
    required this.date,
    required this.icon,
    required this.iconColor,
  });
}
