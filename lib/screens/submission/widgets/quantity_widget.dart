import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../styles/text_style.dart';
import '../submission_controller.dart';

class QuantityWidget extends GetView<SubmissionController> {
  const QuantityWidget({super.key});

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
              'Quantity / Weight',
              style: AppTextStyles.body(context),
            ),

            SizedBox(height: 8.h),

            /// Input
            Container(
              height: 40.h,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: colors.surfaceVariant,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                style: AppTextStyles.body(context),
                onChanged: controller.setQuantity,
                decoration: InputDecoration(
                  hintText: 'Enter number of items or weight in kg',
                  hintStyle: AppTextStyles.small(context),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
