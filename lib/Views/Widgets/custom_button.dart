import 'package:flutter/material.dart';
import 'package:shakwa/Core/Constants/app_color.dart';

class CustomButton extends StatelessWidget {
    const CustomButton({super.key,required this.text,required this.onTap});
  final String text;
  final  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onTap,
        child:  Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
