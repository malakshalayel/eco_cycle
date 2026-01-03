import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/app_colors.dart';
import '../submissions_review_controller.dart';

class SubmissionsListSection extends StatelessWidget {
  const SubmissionsListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubmissionsReviewController>(
      builder: (controller) {
        final items = controller.visibleSubmissions;

        if (items.isEmpty) {
          return Center(
            child: Text(
              'No submissions found',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
              ),
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          itemCount: items.length,
          separatorBuilder: (_, __) => SizedBox(height: 10.h),
          itemBuilder: (context, index) {
            return _SubmissionCard(item: items[index]);
          },
        );
      },
    );
  }
}

class _SubmissionCard extends StatelessWidget {
  final AdminSubmissionItem item;

  const _SubmissionCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<SubmissionsReviewController>();

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.primary.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top info row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: const Icon(Icons.image, color: Colors.white),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.userName,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      item.materialTitle,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '${item.location}\n${item.date}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              _StatusBadge(status: item.status),
            ],
          ),

          SizedBox(height: 10.h),

          // Points
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${item.points} points',
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          SizedBox(height: 10.h),

          // Bottom section depends on status
          if (item.status == SubmissionStatus.pending) ...[
            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    text: 'Approve',
                    bg: AppColors.primary.withOpacity(0.15),
                    fg: AppColors.primary,
                    onTap: () => c.approve(item.id),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: _ActionButton(
                    text: 'Reject',
                    bg: Colors.red.withOpacity(0.12),
                    fg: Colors.red,
                    onTap: () => c.reject(item.id),
                  ),
                ),
              ],
            ),
          ] else if (item.status == SubmissionStatus.approved) ...[
            Text(
              'Approved and points awarded',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ] else ...[
            if (item.rejectReason != null)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 8.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: Colors.red.withOpacity(0.35),
                  ),
                ),
                child: Text(
                  item.rejectReason!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final SubmissionStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    late final String text;
    late final Color bg;
    late final Color fg;// لون النص

    switch (status) {
      case SubmissionStatus.pending:
        text = 'Pending';
        bg = const Color(0xFFFFF3CD);
        fg = const Color(0xFF856404);
        break;
      case SubmissionStatus.approved:
        text = 'Approved';
        bg = const Color(0xFFD4EDDA);
        fg = const Color(0xFF155724);
        break;
      case SubmissionStatus.rejected:
        text = 'Rejected';
        bg = const Color(0xFFF8D7DA);
        fg = const Color(0xFF721C24);
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: fg,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String text;
  final Color bg;
  final Color fg;
  final VoidCallback onTap;

  const _ActionButton({
    required this.text,
    required this.bg,
    required this.fg,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10.r),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: fg,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
