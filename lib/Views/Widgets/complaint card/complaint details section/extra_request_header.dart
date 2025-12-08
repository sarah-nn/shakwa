import 'package:flutter/material.dart';
import 'package:shakwa/Core/Constants/app_color.dart';

class ExtraRequestHeader extends StatelessWidget {
  const ExtraRequestHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: AppColor.primaryColor),
            onPressed: () => Navigator.pop(context),
          ),
          const Expanded(
            child: Text(
              'طلب معلومات إضافية',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}
