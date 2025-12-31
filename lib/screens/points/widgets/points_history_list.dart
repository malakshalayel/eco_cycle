import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../points_controller.dart';
import '../../../constants/app_colors.dart';

class PointsHistoryList extends GetView<PointsController> {
  const PointsHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text(
            'Conversion History',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
      
          SizedBox(height: 12.h),
      
          /// Empty State
          if (controller.history.isEmpty)
            const _EmptyHistoryState()
          else
            Column(
              children: controller.history.map((item) {
                return _HistoryCard(item: item);
              }).toList(),
            ),
        ],
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final PointsHistoryItem item;

  const _HistoryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final bool isApproved = item.status == 'Approved';

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.6),
          width: 1.3,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Left Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 6.h),

                Text(
                  item.date,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.grey,
                  ),
                ),

                SizedBox(height: 6.h),

                Text(
                  'Points used: ${item.points.abs()}',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),

          /// Status Badge
          _StatusBadge(
            title: item.status,
            isApproved: isApproved,
          ),
        ],
      ),
    );
  }
}
class _StatusBadge extends StatelessWidget {
  final String title;
  final bool isApproved;

  const _StatusBadge({
    required this.title,
    required this.isApproved,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 6.h,
      ),
      decoration: BoxDecoration(
        color: isApproved
            ? Colors.green.withOpacity(0.15)
            : Colors.orange.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
          color: isApproved ? Colors.green : Colors.orange,
        ),
      ),
    );
  }
}
class _EmptyHistoryState extends StatelessWidget {
  const _EmptyHistoryState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 32.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.4),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.history,
            size: 36.sp,
            color: AppColors.primary.withOpacity(0.6),
          ),
          SizedBox(height: 12.h),
          Text(
            'No conversions yet',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Your conversion history will appear here',
            style: TextStyle(
              fontSize: 11.sp,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
