import 'package:flutter/material.dart';
import 'package:shakwa/Core/Constants/app_color.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,

  primary: AppColor.primaryColor,
  onPrimary: Colors.white,

 secondary: AppColor.primaryColor,
  onSecondary: Colors.white,

  surface: Colors.white,
  onSurface: Colors.black,

  background: Color.fromARGB(255, 241, 248, 247),
  onBackground:  Colors.black,

  error: Colors.red,
  onError: Colors.white,
);




const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,

  primary: AppColor.primaryColor,
  onPrimary: Colors.white,

  secondary: Color.fromRGBO(229, 238, 255, 0.15),
  onSecondary: Colors.white,

  surface: Color(0xff242424),
  onSurface: Colors.white,

   background: Color(0xFF181818),
  onBackground:  Colors.white,

  error: Colors.redAccent,
  onError: Colors.black,
);
