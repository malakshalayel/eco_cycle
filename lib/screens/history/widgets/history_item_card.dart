import 'package:eco_cycle/screens/history/model/submission_model.dart';
import 'package:eco_cycle/screens/history/submission_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'history_status_badge.dart';
class HistoryItemCard extends StatelessWidget {
  final SubmissionModel item;

  const HistoryItemCard({super.key, required this.item});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Get.to(() => SubmissionDetailsView(submission: item));
      },
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: theme.colorScheme.primary.withOpacity(0.25),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.network(
                    item.imageUrl,
                    width: 70.w,
                    height: 80.h,
                    fit: BoxFit.cover,
                  ),
                ),

                SizedBox(width: 12.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.materialType,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Quantity: ${item.quantity}',
                        style: theme.textTheme.bodySmall,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        _formatDate(item.createdAt),
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),

                HistoryStatusBadge(status: item.status),
              ],
            ),

            if (item.status == SubmissionStatus.approved)
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '+${item.pointsAwarded} pts',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) =>
      '${date.day}/${date.month}/${date.year}';
}
