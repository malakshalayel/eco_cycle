import 'package:eco_cycle/constants/app_colors.dart';
import 'package:eco_cycle/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../home_controller.dart';
class HomeHeaderWidget extends GetView<HomeController> {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GetBuilder<HomeController>(
      builder: (controller) {
        if (controller.isLoading) {
          return const _HeaderSkeleton();
        }

        return GestureDetector(
          onTap: () => Get.toNamed(Routes.PROFILE),
          child: Container(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 40.h),
            color: theme.colorScheme.primary,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28.r,
                  backgroundImage: controller.photoUrl.isNotEmpty
                      ? NetworkImage(controller.photoUrl)
                      : null,
                  backgroundColor: theme.colorScheme.onPrimary.withOpacity(0.2),
                  child: controller.photoUrl.isEmpty
                      ? Icon(Icons.person, color: theme.colorScheme.onPrimary)
                      : null,
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, ${controller.userName}',
                      style: TextStyle(
                        color: theme.colorScheme.onPrimary,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Eco Warrior level 3',
                      style: TextStyle(
                        color: theme.colorScheme.onPrimary.withOpacity(0.7),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


class _HeaderSkeleton extends StatelessWidget {
  const _HeaderSkeleton();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final baseColor = isDark
        ? Colors.white.withOpacity(0.08)
        : Colors.black.withOpacity(0.08);

    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 40.h, bottom: 16.h),
      color: AppColors.primary,
      child: Row(
        children: [
          /// Avatar Skeleton
          Container(
            width: 56.r,
            height: 56.r,
            decoration: BoxDecoration(
              color: baseColor,
              shape: BoxShape.circle,
            ),
          ),

          SizedBox(width: 12.w),

          /// Text Skeletons
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SkeletonLine(
                width: 140.w,
                height: 14.h,
                color: baseColor,
              ),
              SizedBox(height: 8.h),
              _SkeletonLine(
                width: 100.w,
                height: 10.h,
                color: baseColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 🔹 Reusable line
class _SkeletonLine extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const _SkeletonLine({
    required this.width,
    required this.height,

    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
