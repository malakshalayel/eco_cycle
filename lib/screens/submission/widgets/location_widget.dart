import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../styles/text_style.dart';
import '../submission_controller.dart';

class LocationWidget extends GetView<SubmissionController> {
  const LocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 333.w,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            width: 2,
            color: const Color(0xFF37CE76).withOpacity(0.5),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, 
          children: [
            // Title
            Text(
              'Collection Location',
              style: AppTextStyles.body,
            ),

            SizedBox(height: 8.h),

            // Input
            Container(
              
              height: 38.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                color: AppColors.greyLight,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: TextField(
                onChanged: controller.setLocation,
                decoration: const InputDecoration(
                  icon: Icon(Icons.location_on, size: 18),
                  hintText: 'Enter Your location or address',
                  border: InputBorder.none,
                ),
              ),
            ),

            SizedBox(height: 10.h),

            // Button
            SizedBox(
              height: 38.h,
              child: OutlinedButton(
                onPressed: controller.useCurrentLocation,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Color(0xFF37CE76),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  'Use Current Location',
                  style: TextStyle(
                    color: const Color(0xFF37CE76),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
