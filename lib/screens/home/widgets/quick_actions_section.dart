import 'package:eco_cycle/routes/app_routes.dart';
import 'package:eco_cycle/screens/history/history_view.dart';
import 'package:eco_cycle/screens/points/points_view.dart';
import 'package:eco_cycle/screens/submission/submission_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          _ActionItem(
            title: 'Submit Recyclable',
            icon: Icons.upload_outlined,
            color: const Color(0xff304CD8),
            onTap: () {
              Get.toNamed(Routes.SUBMISSION);
            },
          ),

          _ActionItem(
            title: 'View History',
            icon: Icons.history,
            color: AppColors.primary,
            onTap: () {
                 Get.toNamed(Routes.SUBMISSION_HISTORY);
            },
          ),

          _ActionItem(
            title: 'Redeem Points',
            icon: Icons.card_giftcard,
            color: Colors.orange,
            onTap: () {
                 Get.toNamed(Routes.POINTS);
            },
          ),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionItem({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        margin: EdgeInsets.only(top: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            width: 2,
            color: const Color(0xFF37CE76).withOpacity(0.5),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(40.r),
              ),
              child: Icon(icon, color: Colors.black, size: 22.sp),
            ),

            SizedBox(width: 10.w),
            Expanded(child: Text(title)),
            const Icon(Icons.arrow_forward, size: 30, color: AppColors.primary),
            SizedBox(width: 16.w),
          ],
        ),
      ),
    );
  }
}
