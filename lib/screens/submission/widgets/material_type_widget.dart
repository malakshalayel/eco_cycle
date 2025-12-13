import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../styles/text_style.dart';
import '../submission_controller.dart';

class MaterialTypeWidget extends GetView<SubmissionController> {
  const MaterialTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // ===== Card =====
          Container(
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
              children: [
                Text('Material Type', style: AppTextStyles.body),
                SizedBox(height: 8.h),

                GestureDetector(
                  onTap: controller.toggleMaterial,
                  child: Container(
                    height: 40.h,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: AppColors.greyLight,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.materialType ??
                              'Select material type',
                          style: TextStyle(
                            color: controller.materialType == null
                                ? AppColors.grey
                                : AppColors.black,
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ===== Dropdown =====
          if (controller.isMaterialOpen)
            Container(
              width: 289.w,
              height: 164.h,
              margin: EdgeInsets.only(top: 6.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(
                  width: 1,
                  color: Colors.black.withOpacity(0.5),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                children: controller.materials.map((item) {
                  final isSelected = item == controller.materialType;

                  return InkWell(
                    onTap: () => controller.selectMaterial(item),
                    child: Container(
                      height: 32.h,
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      color: isSelected
                          ? AppColors.greyLight
                          : Colors.transparent,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        item,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
