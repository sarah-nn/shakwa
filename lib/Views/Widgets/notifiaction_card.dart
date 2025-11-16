import 'package:flutter/material.dart';
import 'package:shakwa/Models/notification_model.dart';

class NotificationCard extends StatelessWidget {
  final NotificationItem item;

  const NotificationCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // يجب أن يكون اتجاه النص من اليمين إلى اليسار (RTL)
          textDirection: TextDirection.rtl,
          children: [
            // أيقونة الحالة (الدائرة)
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: item.iconColor.withOpacity(0.1), // خلفية خفيفة للأيقونة
                shape: BoxShape.circle,
              ),
              child: Icon(item.icon, color: item.iconColor, size: 24),
            ),
            const SizedBox(width: 12),
            // محتوى الإشعار
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.rtl,
                children: [
                  // رقم الشكوى
                  Text.rich(
                    TextSpan(
                      text: 'شكوى رقم  ',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: item.complaintNumber,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: item.iconColor, // لون رقم الشكوى
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.right, // لمحاذاة النص لليمين
                  ),
                  const SizedBox(height: 4),
                  // نص الإشعار
                  Text(
                    item.title,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                    textAlign: TextAlign.right, // لمحاذاة النص لليمين
                  ),
                  const SizedBox(height: 4),
                  // التاريخ
                  Text(
                    item.date,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    textAlign: TextAlign.right, // لمحاذاة النص لليمين
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
