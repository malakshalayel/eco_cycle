import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: Get.locale?.countryCode == 'en' ? 'Roboto' : 'Cairo',
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      foregroundColor: Colors.black,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.black,
    fontFamily: Get.locale?.countryCode == 'en' ? 'Roboto' : 'Cairo',
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0,
      centerTitle: true,
      foregroundColor: Colors.white,
    ),
  );
}
