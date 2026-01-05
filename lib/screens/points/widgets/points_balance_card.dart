import 'package:eco_cycle/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../points_controller.dart';

class PointsBalanceCard extends GetView<PointsController> {
  const PointsBalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
                            color: theme.colorScheme.primary,

                  image: DecorationImage(
                    image: AssetImage(ecoBackground),
                    fit: BoxFit.cover,
                    repeat: ImageRepeat.repeat, // مهم للـ texture
                    colorFilter: ColorFilter.mode(
                      theme.colorScheme.primary.withOpacity(.2),
                      BlendMode.srcATop,
                    ),
                  ),
                ),
      padding: EdgeInsets.all(16.w),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title
                Text(
                  'Available Points',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 6.h),

                /// Points Value
                Text(
                  controller.pointsBalance.toString(),
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),

                SizedBox(height: 8.h),

                /// Cash Value
                Text(
                  '≈ \$${controller.cashValue.toStringAsFixed(2)} value',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
