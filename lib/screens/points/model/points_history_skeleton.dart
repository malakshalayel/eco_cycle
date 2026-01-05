import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PointsHistorySkeleton extends StatelessWidget {
  const PointsHistorySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
        children: List.generate(
          3,
          (index) => Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 14.h, width: 120.w),
                      SizedBox(height: 6.h),
                      Container(height: 10.h, width: 80.w),
                      SizedBox(height: 6.h),
                      Container(height: 10.h, width: 100.w),
                    ],
                  ),
                ),
                Container(height: 24.h, width: 60.w),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
