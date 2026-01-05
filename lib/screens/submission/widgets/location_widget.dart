import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../styles/text_style.dart';
import '../submission_controller.dart';

class LocationWidget extends GetView<SubmissionController> {
  const LocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Center(
      child: Container(
        width: 333.w,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            width: 1.5,
            color: colors.primary.withOpacity(0.4),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Title
            Text(
              'Collection Location',
              style: AppTextStyles.body(context),
            ),

            SizedBox(height: 8.h),

            /// Input
            Container(
              height: 40.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                color: theme.inputDecorationTheme.fillColor ??
                    colors.surfaceVariant,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: TextField(
                controller: controller.locationController,
                readOnly: true,
                style: AppTextStyles.body(context),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.location_on,
                    size: 18,
                    color: colors.primary,
                  ),
                  hintText: 'Enter your location',
                  hintStyle: AppTextStyles.small(context),
                  border: InputBorder.none,
                ),
              ),
            ),

            SizedBox(height: 12.h),

            /// Button
            SizedBox(
              height: 38.h,
              width: double.infinity,
              child: OutlinedButton(
                onPressed: controller.useCurrentLocation,
                style: OutlinedButton.styleFrom(
                  foregroundColor: colors.primary,
                  side: BorderSide(color: colors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  'Use Current Location',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
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
