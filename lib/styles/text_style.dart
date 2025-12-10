import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_colors.dart';

class AppTextStyles {
  // Titles
  static TextStyle h1 = TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static TextStyle h2 = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  // Body Text
  static TextStyle body = TextStyle(fontSize: 16.sp, color: AppColors.black);

  static TextStyle bodyGrey = TextStyle(
    fontSize: 16.sp,
    color: AppColors.greyDark,
  );

  // Small Text
  static TextStyle small = TextStyle(
    fontSize: 13.sp,
    color: AppColors.greyDark,
  );

  // Buttons
  static TextStyle button = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
}
