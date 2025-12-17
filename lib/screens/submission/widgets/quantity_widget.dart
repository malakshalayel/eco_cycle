import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../styles/text_style.dart';
import '../submission_controller.dart';

class QuantityWidget extends GetView<SubmissionController> {
  const QuantityWidget({super.key});

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
            Text('Quantity/Weight', style: AppTextStyles.body),
            SizedBox(height: 8.h),

            Container(
              height: 40.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                color: AppColors.greyLight,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: controller.setQuantity,
                decoration: const InputDecoration(
                  hintText: 'Enter number of items or weight in kg',
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
