import 'package:flutter/material.dart';
import 'package:shakwa/Core/Constants/app_color.dart';

AppBar customAppBar(String title) {
  return AppBar(
    title: Text(title),
    centerTitle: true,
    titleTextStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      fontFamily: "cairo",
    ),
    // backgroundColor: AppColor.primaryColor,
    // foregroundColor: Colors.white,
  );
}
