import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../constants/app_colors.dart';
import '../points_review_controller.dart';

class PointsReviewListSection extends StatelessWidget {
  const PointsReviewListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PointsReviewController>(
      builder: (controller) {
        final items = controller.visibleRedemptions;

        if (items.isEmpty) {
          return Center(
            child: Text(
              'No requests found',
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
            return _RedemptionCard(item: items[index]);
          },
        );
      },
    );
  }
}

class _RedemptionCard extends StatelessWidget {
  final AdminRedemptionItem item;

  const _RedemptionCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<PointsReviewController>();

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
                child: const Icon(Icons.payments, color: Colors.white),
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
                      '${item.points} points',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '\$${item.cashValue.toStringAsFixed(2)} • ${item.date}',
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
          if (item.status == RedemptionStatus.pending) ...[
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
                    onTap: () => _showRejectDialog(c, item.id),
                  ),
                ),
              ],
            ),
          ] else if (item.status == RedemptionStatus.approved) ...[
            Text(
              'Approved conversion',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ] else ...[
            if (item.note != null)
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
                  item.note!,
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
  final RedemptionStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    late final String text;
    late final Color bg;
    late final Color fg;

    switch (status) {
      case RedemptionStatus.pending:
        text = 'Pending';
        bg = const Color(0xFFFFF3CD);
        fg = const Color(0xFF856404);
        break;
      case RedemptionStatus.approved:
        text = 'Approved';
        bg = const Color(0xFFD4EDDA);
        fg = const Color(0xFF155724);
        break;
      case RedemptionStatus.rejected:
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

void _showRejectDialog(PointsReviewController controller, String id) {
  final TextEditingController reasonController = TextEditingController();

  Get.defaultDialog(
    title: 'Reject Redemption',
    content: Column(
      children: [
        TextField(
          controller: reasonController,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: 'Enter reject reason',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    ),
    textConfirm: 'Reject',
    textCancel: 'Cancel',
    onConfirm: () {
      final reason = reasonController.text.trim();
      if (reason.isEmpty) {
        Get.snackbar('Error', 'Please enter a reason');
        return;
      }
      controller.reject(id, reason: reason);
      Get.back();
    },
  );
}
