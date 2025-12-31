import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../points_controller.dart';
import '../../../constants/app_colors.dart';

class PointsTabs extends GetView<PointsController> {
  const PointsTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PointsController>(
      builder: (_) {
        return Row(
          children: [
            _TabItem(
              title: 'Redeem',
              isActive: controller.currentTab == PointsTab.redeem,
              onTap: () => controller.changeTab(PointsTab.redeem),
            ),
            _TabItem(
              title: 'History',
              isActive: controller.currentTab == PointsTab.history,
              onTap: () => controller.changeTab(PointsTab.history),
            ),
          ],
        );
      },
    );
  }
}

class _TabItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _TabItem({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? AppColors.primary : Colors.grey,
              ),
            ),
            SizedBox(height: 6.h),
            Container(
              height: 2.h,
              color: isActive ? AppColors.primary : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
