import 'package:eco_cycle/screens/history/model/submission_model.dart';
import 'package:eco_cycle/screens/history/widgets/history_status_badge.dart';
import 'package:eco_cycle/widgets/app_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/app_colors.dart';
class SubmissionDetailsView extends StatelessWidget {
  final SubmissionModel submission;

  const SubmissionDetailsView({
    super.key,
    required this.submission,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppAppBar(title: "Submission Details"),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🖼 Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.network(
                submission.imageUrl,
                width: double.infinity,
                height: 220.h,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(height: 16.h),

            /// ⭐ Summary Card
            _SummaryCard(submission: submission),

            SizedBox(height: 20.h),

            /// 📦 Item Details
            _SectionTitle('Item Details'),
            _InfoTile('Material Type', submission.materialType),
            _InfoTile('Quantity / Weight', submission.quantity),
            _InfoTile('Location', submission.location),

            SizedBox(height: 20.h),

            /// ⏳ Timeline
            _SectionTitle('Submission Status'),
            _StatusTimeline(status: submission.status),

            /// ❌ Admin Note
            if (submission.status == SubmissionStatus.rejected &&
                submission.note != null)
              _AdminNote(note: submission.note!),
          ],
        ),
      ),
    );
  }
}
class _SummaryCard extends StatelessWidget {
  final SubmissionModel submission;

  const _SummaryCard({required this.submission});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Status',
                style: theme.textTheme.bodySmall,
              ),
              SizedBox(height: 4.h),
              HistoryStatusBadge(status: submission.status),
            ],
          ),

          if (submission.status == SubmissionStatus.approved)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Points Earned', style: theme.textTheme.bodySmall),
                SizedBox(height: 4.h),
                Text(
                  '+${submission.pointsAwarded}',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
class _InfoTile extends StatelessWidget {
  final String title;
  final String value;

  const _InfoTile(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.bodySmall),
          SizedBox(height: 4.h),
          Text(
            value,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
class _StatusTimeline extends StatelessWidget {
  final SubmissionStatus status;

  const _StatusTimeline({required this.status});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TimelineItem('Submitted', true),
        _TimelineItem('Under Review', status != SubmissionStatus.pending),
        _TimelineItem(
          status == SubmissionStatus.approved ? 'Approved' : 'Rejected',
          status != SubmissionStatus.pending,
        ),
      ],
    );
  }
}
class _AdminNote extends StatelessWidget {
  final String note;

  const _AdminNote({required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.red),
      ),
      child: Text(
        note,
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
class _TimelineItem extends StatelessWidget {
  final String title;
  final bool isCompleted;

  const _TimelineItem(
    this.title,
    this.isCompleted, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final Color activeColor =
        isCompleted ? theme.colorScheme.primary : Colors.grey;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          /// ● Circle
          Container(
            width: 14.r,
            height: 14.r,
            decoration: BoxDecoration(
              color: activeColor,
              shape: BoxShape.circle,
            ),
          ),

          SizedBox(width: 12.w),

          /// Text
          Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: isCompleted
                  ? theme.textTheme.bodyLarge?.color
                  : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
