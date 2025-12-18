import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../submission_controller.dart';

class SubmitButtonWidget extends GetView<SubmissionController> {
  const SubmitButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
       
        height: 55.h,
        child: ElevatedButton(
          onPressed: controller.canSubmit ? controller.submit : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            disabledBackgroundColor: const Color(0xFFD9D9D9),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: controller.isLoading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(
                  'Submit for Review',
                  style: TextStyle(
                    color: controller.canSubmit
                        ? Colors.white
                        : Colors.white.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
      ),
    );
  }
}

