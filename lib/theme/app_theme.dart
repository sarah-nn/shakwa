import 'package:flutter/material.dart';
import 'package:shakwa/theme/color_schemes.dart';

// class AppTheme {
//   static ThemeData lightTheme = ThemeData(
//     useMaterial3: true,
//      fontFamily: 'Cairo',
//     colorScheme: lightColorScheme,
//     scaffoldBackgroundColor: lightColorScheme.background,
//     inputDecorationTheme: InputDecorationTheme(
//       // filled: true,
//       // fillColor: const Color.fromARGB(255, 242, 240, 240),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//     ),
//      appBarTheme: AppBarTheme(
//       backgroundColor: lightColorScheme.primary, 
//       foregroundColor: lightColorScheme.onPrimary,
//     ),
//     floatingActionButtonTheme: FloatingActionButtonThemeData(
//       backgroundColor: lightColorScheme.secondary, 
//       foregroundColor: lightColorScheme.onSecondary,
//     ),
//   );

//   static ThemeData darkTheme = ThemeData(
//      fontFamily: 'Cairo',
//     useMaterial3: true,
//     colorScheme: darkColorScheme,
//     scaffoldBackgroundColor: darkColorScheme.background,
//     inputDecorationTheme: InputDecorationTheme(
//       // filled: true,
//       // fillColor: Colors.grey.shade800,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//     ),
//      appBarTheme: AppBarTheme(
//       backgroundColor: darkColorScheme.surface, 
//       foregroundColor: darkColorScheme.onSurface,
//     ),
//     floatingActionButtonTheme: FloatingActionButtonThemeData(
//       backgroundColor: darkColorScheme.primary,  
//       foregroundColor: darkColorScheme.onPrimary,
//     ),
//   );
// }
class AppTheme {
  static ThemeData _baseTheme(ColorScheme scheme) {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Cairo',
      colorScheme: scheme,

      scaffoldBackgroundColor: scheme.background,

      inputDecorationTheme: InputDecorationTheme(
      hintStyle:  TextStyle(fontSize: 12, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
         enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: scheme.primary, width: 0.77),
              borderRadius: BorderRadius.circular(7.69),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: scheme.primary, width: 0.77),
              borderRadius: BorderRadius.circular(7.69),
            ),

      ),
      dialogTheme: DialogTheme(
  backgroundColor: scheme.background,
  surfaceTintColor: Colors.transparent, 
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
),

      appBarTheme: AppBarTheme(
        backgroundColor:
            scheme.brightness == Brightness.dark ? scheme.surface : scheme.primary,
        foregroundColor:
            scheme.brightness == Brightness.dark ? scheme.onSurface : scheme.onPrimary,
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
      ),

//       elevatedButtonTheme: ElevatedButtonThemeData(
//   style: ElevatedButton.styleFrom(
//     backgroundColor: scheme.primary,
//     foregroundColor: scheme.onPrimary,
//  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//   ),
// ),

    );
  }

  static ThemeData lightTheme = _baseTheme(lightColorScheme);
  static ThemeData darkTheme = _baseTheme(darkColorScheme);
}
