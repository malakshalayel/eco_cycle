import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constants/app_colors.dart';
import '../submissions_review_controller.dart';

class SubmissionsTopSection extends StatelessWidget {
  const SubmissionsTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubmissionsReviewController>(
      builder: (controller) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12.r),
              bottomRight: Radius.circular(12.r),
            ),
          ),
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  Header
              Row(
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Submissions Review',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          controller.filterSummaryText,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12.h),

              //  Search
              Container(
                height: 44.h,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: TextField(
                        onChanged: controller.onSearchChanged,
                        style: TextStyle(fontSize: 14.sp),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'search by user or material',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10.h),

              //  Filter Field
              InkWell(
                onTap: controller.toggleFilter,
                child: Container(
                  height: 44.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          controller.selectedFilter,
                          style: TextStyle(fontSize: 13.sp),
                        ),
                      ),
                      Icon(
                        controller.isFilterOpen
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 20.sp,
                      ),
                    ],
                  ),
                ),
              ),
              if (controller.isFilterOpen) ...[
                SizedBox(height: 6.h),
                Container(
                  height: 164.h,
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
                    children: controller.filterOptions.map((item) {
                      final isSelected = item == controller.selectedFilter;

                      return InkWell(
                        onTap: () => controller.selectFilter(item),
                        child: Container(
                          height: 32.h,
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          alignment: Alignment.centerLeft,
                          color: isSelected
                              ? AppColors.greyLight
                              : Colors.transparent,
                          child: Text(
                            item,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
