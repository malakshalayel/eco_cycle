import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  // Titles
  static TextStyle h1(BuildContext context) => TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).textTheme.bodyLarge?.color,
      );

  static TextStyle h2(BuildContext context) => TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).textTheme.bodyLarge?.color,
      );

  // Body Text
  static TextStyle body(BuildContext context) => TextStyle(
        fontSize: 16.sp,
        color: Theme.of(context).textTheme.bodyMedium?.color,
      );

  static TextStyle bodyGrey(BuildContext context) => TextStyle(
        fontSize: 16.sp,
        color: Theme.of(context).textTheme.bodySmall?.color,
      );

  // Small Text
  static TextStyle small(BuildContext context) => TextStyle(
        fontSize: 13.sp,
        color: Theme.of(context).textTheme.bodySmall?.color,
      );

  // Buttons (غالبًا أبيض على Primary)
  static TextStyle button(BuildContext context) => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onPrimary,
      );
}
