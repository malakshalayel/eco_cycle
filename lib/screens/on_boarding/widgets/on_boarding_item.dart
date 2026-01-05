import 'package:eco_cycle/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Image
          Image.asset(
            image,
            width: 260.w,
            height: 260.h,
            fit: BoxFit.contain,
          ),

          SizedBox(height: 32.h),

          /// Title
          Text(
            title,
            style: AppTextStyles.h2(context),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 10.h),

          /// Subtitle
          Text(
            subtitle,
            style: AppTextStyles.bodyGrey(context),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
