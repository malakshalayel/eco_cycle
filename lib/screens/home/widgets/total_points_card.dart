import 'package:eco_cycle/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TotalPointsCard extends StatelessWidget {
  final int totalPoints;
  final int weeklyPoints;

  const TotalPointsCard({
    super.key,
    required this.totalPoints,
    required this.weeklyPoints,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
        decoration: BoxDecoration(
                          //  color: theme.colorScheme.primary,

                  image: DecorationImage(
                    image: AssetImage(ecoBackground),
                    fit: BoxFit.cover,
                    repeat: ImageRepeat.repeat, // مهم للـ texture
                    colorFilter: ColorFilter.mode(
                      theme.colorScheme.primary.withOpacity(.4),
                      BlendMode.srcATop,
                    ),
                  ),
                ),
      padding: EdgeInsets.all(16.w),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: theme.cardColor, // adapts to light/dark
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title
                Text(
                  'Total Points',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 6.h),

                /// Points Value
                Text(
                  totalPoints.toString(),
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.primary,
                  ),
                ),

                SizedBox(height: 10.h),

                /// Weekly Gain
                Text(
                  '+$weeklyPoints points this week',
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
