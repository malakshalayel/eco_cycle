import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../submission_controller.dart';

class UploadItemWidget extends GetView<SubmissionController> {
  const UploadItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: controller.pickImage,
        child: Container(
          width: 333.w,
          height: 194.h,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              width: 2,
              color: const Color(0xFF37CE76).withOpacity(0.5),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.camera_alt_outlined,
                size: 36,
                color: AppColors.grey,
              ),
              SizedBox(height: 8),
              Text(
                'Upload item',
                style: TextStyle(
                  color: AppColors.greyDark,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
