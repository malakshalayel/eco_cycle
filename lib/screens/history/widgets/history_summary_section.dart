import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../history_controller.dart';
import '../../../constants/app_colors.dart';
class HistorySummarySection extends StatelessWidget {
  const HistorySummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(16.w),
      color: theme.colorScheme.primary,
      child: GetBuilder<HistoryController>(
        builder: (controller) {
          return Row(
            children: [
              _SummaryCard(
                title: 'Total Submissions',
                value: controller.totalSubmissions.toString(),
              ),
              SizedBox(width: 20.w),
              _SummaryCard(
                title: 'Points Earned',
                value: controller.totalPoints.toString(),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;

  const _SummaryCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.bodySmall),
            SizedBox(height: 6.h),
            Text(
              value,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
