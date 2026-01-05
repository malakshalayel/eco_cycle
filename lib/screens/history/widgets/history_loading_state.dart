import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';



class HistoryItemSkeleton extends StatelessWidget {
  const HistoryItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          _box(70.w, 50.h),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _box(120.w, 14.h),
                SizedBox(height: 8.h),
                _box(80.w, 12.h),
                SizedBox(height: 8.h),
                _box(60.w, 10.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _box(double w, double h) => Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(6),
        ),
      );
}
