import 'package:eco_cycle/constants/app_colors.dart';
import 'package:eco_cycle/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../admin_home_controller.dart';

class AdminHomeTopSection extends GetView<AdminHomeController> {
  const AdminHomeTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12.r),
          bottomRight: Radius.circular(12.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Admin Dashboard',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'EcoCycle Management Portal',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: (){ Get.toNamed(Routes.ADMIN_LOGIN);},
                child: Row(
                  children: const [
                    Icon(Icons.logout, color: Colors.white, size: 18),
                    SizedBox(width: 4),
                    Text('LogOut', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          Row(
            children: [
              _StatCard(
                title: 'Total Submissions',
                value: controller.totalSubmissions.toString(),
                change: '+12% vs last month',
                changeColor: Colors.green,
              ),
              SizedBox(width: 12.w),
              _StatCard(
                title: 'Active Users',
                value: controller.activeUsers.toString(),
                change: '+8% vs last month',
                changeColor: Colors.green,
              ),
            ],
          ),

          SizedBox(height: 12.h),

          Row(
            children: [
              _StatCard(
                title: 'Points Awarded',
                value: controller.pointsAwarded.toString(),
                change: '+15% vs last month',
                changeColor: Colors.green,
              ),
              SizedBox(width: 12.w),
              _StatCard(
                title: 'Pending Reviews',
                value: controller.pendingReviews.toString(),
                change: '-5% vs last month',
                changeColor: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final Color changeColor;

  const _StatCard({
    required this.title,
    required this.value,
    required this.change,
    required this.changeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500)),
            SizedBox(height: 6.h),
            Text(
              value,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              change,
              style: TextStyle(fontSize: 11.sp, color: changeColor),
            ),
          ],
        ),
      ),
    );
  }
}
