import 'package:flutter/material.dart';
import 'package:shakwa/Core/Constants/app_color.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('الموقع', style: TextStyle(fontSize: 14)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: 'ادخل الموقع هنا ...',
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
