import 'package:evently_app/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData Light = ThemeData(
      scaffoldBackgroundColor: AppColor.lightbackgroundColor,
      textTheme: const TextTheme(
        bodySmall: TextStyle(color: Colors.black, fontSize: 14),
        bodyMedium: TextStyle(color: Colors.black, fontSize: 16),
        bodyLarge: TextStyle(color: Colors.black, fontSize: 20),
      ),
      iconTheme: const IconThemeData(color: Color(0xff7B7B7B)));
  static ThemeData Dark = ThemeData(
      scaffoldBackgroundColor: AppColor.darkbackgroundColor,
      textTheme: const TextTheme(
        bodySmall: TextStyle(color: Colors.white, fontSize: 14),
        bodyMedium: TextStyle(color: Colors.white, fontSize: 16),
        bodyLarge: TextStyle(color: Colors.white, fontSize: 20),
      ),
      iconTheme: const IconThemeData(color: Colors.white));
}
