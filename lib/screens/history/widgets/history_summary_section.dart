import 'package:eco_cycle/screens/history/model/submission_model.dart';
import 'package:eco_cycle/screens/submission/submission_controller.dart';
import 'package:eco_cycle/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../history_controller.dart';
import '../../../constants/app_colors.dart';
class HistorySummarySection extends GetView<HistoryController> {
  const HistorySummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
      child: StreamBuilder<List<SubmissionModel>>(
          stream: controller.historyStream(),
  builder: (BuildContext context, AsyncSnapshot<List<SubmissionModel>> snapshot) { 
      if (!snapshot.hasData) return const SizedBox();

    final submissions = snapshot.data!;

    final totalSubmissions = submissions.length;

    final totalPoints = submissions
        .where((e) => e.status == SubmissionStatus.approved)
        .fold<int>(0, (sum, e) => sum + e.pointsAwarded);
return Row(
            children: [
              _SummaryCard(
                title: 'Total Submissions',
                value:totalSubmissions.toString(),
              ),
              SizedBox(width: 20.w),
              _SummaryCard(
                title: 'Points Earned',
                value: totalPoints.toString(),
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
