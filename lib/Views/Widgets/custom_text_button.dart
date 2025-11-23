import 'package:flutter/material.dart';
import 'package:shakwa/Core/Constants/app_color.dart';

class CustomTextButtomAuth extends StatelessWidget {
  const CustomTextButtomAuth({
    required this.one,
    required this.tow,
    required this.onTap,
    super.key,
  });
 final String one;
 final String tow;
 final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(one),
            GestureDetector(
              onTap: onTap,
              child: Text(
                tow,
                style: TextStyle(color: AppColor.primaryColor, fontSize: 16),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
