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
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),

          _ActionItem(
            title: 'Submit Recyclable',
            icon: Icons.upload_outlined,
            color: theme.colorScheme.primary,
            onTap: () => Get.toNamed(Routes.SUBMISSION),
          ),

          _ActionItem(
            title: 'View History',
            icon: Icons.history,
            color: theme.colorScheme.secondary,
            onTap: () => Get.toNamed(Routes.SUBMISSION_HISTORY),
          ),

          _ActionItem(
            title: 'Redeem Points',
            icon: Icons.card_giftcard,
            color: Colors.orange.shade600,
            onTap: () => Get.toNamed(Routes.POINTS),
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
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        margin: EdgeInsets.only(top: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: theme.dividerColor.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            /// Icon Circle
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 22.sp,
              ),
            ),

            SizedBox(width: 12.w),

            /// Title
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: theme.hintColor,
            ),
          ],
        ),
      ),
    );
  }
}
