import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../styles/text_style.dart';
import '../submission_controller.dart';

class MaterialTypeWidget extends StatelessWidget {
  const MaterialTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Center(
      child: GetBuilder<SubmissionController>(
        init: SubmissionController(),
        builder: (controller) {
          return Column(
            children: [
              /// Card
              Container(
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
                  children: [
                    Text(
                      'Material Type',
                      style: AppTextStyles.body(context),
                    ),
                    SizedBox(height: 8.h),
          
                    GestureDetector(
                      onTap: controller.toggleMaterial,
                      child: Container(
                        height: 40.h,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        decoration: BoxDecoration(
                          color: colors.surfaceVariant,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.materialType ??
                                  'Select material type',
                              style: controller.materialType == null
                                  ? AppTextStyles.small(context)
                                  : AppTextStyles.body(context),
                            ),
                            Icon(
                              controller.isMaterialOpen
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: colors.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          
              /// Dropdown
              if (controller.isMaterialOpen)
                Container(
                  width: 289.w,
                  height: 170.h,
                  margin: EdgeInsets.only(top: 6.h),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      width: 1,
                      color: colors.primary.withOpacity(0.4),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: theme.shadowColor.withOpacity(0.15),
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
                          height: 36.h,
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? colors.primary.withOpacity(0.12)
                                : Colors.transparent,
                          ),
                          child: Text(
                            item,
                            style: AppTextStyles.small(context).copyWith(
                              fontWeight:
                                  isSelected ? FontWeight.w600 : FontWeight.w400,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
            ],
          );
        }
      ),
    );
  }
}
