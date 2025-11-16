import 'package:flutter/material.dart';

class ComplaintsItem extends StatelessWidget {
  final String type;
  final String title;
  final String id;
  final String status;

  const ComplaintsItem({
    required this.type,
    required this.title,
    required this.id,
    required this.status,
    super.key,
  });

  // دالة مساعدة لتحديد لون حالة الشكوى
  Color _getStatusColor(String status) {
    if (status == 'تم الإنجاز') {
      return const Color(0xFF00C897); // أخضر
    } else if (status == 'قيد العمل') {
      return Colors.orange; // برتقالي
    } else {
      return Colors.red; // أحمر (لـ "تم الرفع" أو أي حالة أخرى)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 15.0),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // يبدأ المحاذاة من اليمين
          children: <Widget>[
            // 1. نوع الشكوى (مثلاً: بلاغ بيئي)
            Text(
              type,
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
            const SizedBox(height: 8),

            // 2. عنوان الشكوى
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                height: 1.5, // لزيادة تباعد الأسطر
              ),
            ),
            const SizedBox(height: 12),

            // خط فاصل (Divider)
            const Divider(color: Color(0xFFE0E0E0), height: 1, thickness: 1),
            const SizedBox(height: 12),

            // 3. رقم الشكوى والحالة في صف واحد
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // رقم الشكوى
                Row(
                  children: [
                    const Text(
                      'رقم المرجع: ',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    Text(
                      id,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                // حالة الشكوى (بطاقة صغيرة ذات خلفية ملونة)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(
                      status,
                    ).withOpacity(0.1), // خلفية فاتحة للون الحالة
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: _getStatusColor(status), // لون النص هو لون الحالة
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
