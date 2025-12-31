import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../history_controller.dart';

class HistoryStatusBadge extends StatelessWidget {
  final SubmissionStatus status;

  const HistoryStatusBadge({super.key, required this.status});

  Color get color {
    switch (status) {
      case SubmissionStatus.approved:
        return Colors.green;
      case SubmissionStatus.pending:
        return Colors.orange;
      case SubmissionStatus.rejected:
        return Colors.red;
    }
  }

  String get text {
    switch (status) {
      case SubmissionStatus.approved:
        return 'Approved';
      case SubmissionStatus.pending:
        return 'Pending';
      case SubmissionStatus.rejected:
        return 'Rejected';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14.sp,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
