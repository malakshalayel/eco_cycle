import 'package:eco_cycle/screens/points/model/points_history_model.dart';
import 'package:eco_cycle/screens/points/model/points_history_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../points_controller.dart';
import '../../../constants/app_colors.dart';
class PointsHistoryList extends GetView<PointsController> {
  const PointsHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PointsHistoryModel>>(
      stream: controller.historyStream(),
      builder: (context, snapshot) {

        /// 🔄 Loading (first frame)
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const PointsHistorySkeleton();
        }

        /// ❌ No data
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const _EmptyHistoryState();
        }

        final history = snapshot.data!;

        /// ✅ List
        return ListView.separated(
          padding: EdgeInsets.all(16.w),
          itemCount: history.length,
          separatorBuilder: (_, __) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            return _HistoryCard(item: history[index]);
          },
        );
      },
    );
  }
}



class _HistoryCard extends StatelessWidget {
  final PointsHistoryModel item;

  const _HistoryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final status = item.status.toLowerCase();
    final bool isApproved = status == 'approved';

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.6),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status.capitalizeFirst!,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  '${item.date.day}/${item.date.month}/${item.date.year}',
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

          _StatusBadge(
            title: status.capitalizeFirst!,
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
