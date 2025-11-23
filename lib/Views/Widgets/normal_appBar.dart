import 'package:flutter/material.dart';
import 'package:shakwa/Core/Constants/app_color.dart';

class NormalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;

  const NormalAppBar({super.key, required this.text});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(text),
      centerTitle: true,
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        fontFamily: "cairo",
      ),
      backgroundColor: AppColor.primaryColor,
      foregroundColor: Colors.white,
    );
  }
}
