import 'package:eco_cycle/screens/history/model/submission_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import '../history_controller.dart';
class HistoryStatusBadge extends StatelessWidget {
  final SubmissionStatus status;

  const HistoryStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final color = switch (status) {
      SubmissionStatus.approved => theme.colorScheme.primary,
      SubmissionStatus.pending => Colors.orange,
      SubmissionStatus.rejected => Colors.red,
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        status.name.capitalizeFirst!,
        style: theme.textTheme.bodySmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
