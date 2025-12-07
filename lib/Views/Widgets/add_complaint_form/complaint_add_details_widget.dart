import 'package:flutter/material.dart';
import 'package:shakwa/Core/Constants/app_color.dart';

class ComplaintAddDetailsWidget extends StatelessWidget {
  const ComplaintAddDetailsWidget({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('الوصف التفصيلي', style: TextStyle(fontSize: 14)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: 6,
          decoration: InputDecoration(
            hintText: 'اكتب تفاصيل الشكوى هنا...',
            contentPadding: const EdgeInsets.all(12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColor.primaryColor.withOpacity(0.7),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColor.primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
