import 'package:eco_cycle/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/app_colors.dart';

class OnboardingItem extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  const OnboardingItem({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 260.w,
            height: 260.h,
          ),

          SizedBox(height: 32.h),

          Text(title,
              style: AppTextStyles.h2, textAlign: TextAlign.center),

          SizedBox(height: 10.h),

          Text(
            subtitle,
            style: AppTextStyles.bodyGrey,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
