import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class RecentActivityCard extends StatelessWidget {
  const RecentActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: theme.dividerColor.withOpacity(0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Activity',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 16.h),

            _ActivityRow(
              title: 'Plastic bottles submitted',
              points: '+50 pts',
              time: '2 hours ago',
              isPositive: true,
            ),

            SizedBox(height: 18.h),

            _ActivityRow(
              title: 'Points redeemed',
              points: '-50 pts',
              time: '1 day ago',
              isPositive: false,
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  final String title;
  final String points;
  final String time;
  final bool isPositive;

  const _ActivityRow({
    required this.title,
    required this.points,
    required this.time,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isPositive ? Colors.green : Colors.red;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              points,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          time,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.hintColor,
          ),
        ),
      ],
    );
  }
}
