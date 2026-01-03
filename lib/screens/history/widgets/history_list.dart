import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../history_controller.dart';
import 'history_item_card.dart';
import 'history_empty_state.dart';

import 'history_loading_state.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryController>(
      builder: (controller) {

        // ✅ 1. LOADING
        if (controller.isLoading) {
          return const HistoryItemSkeleton();
        }

        // ✅ 2. EMPTY
        if (controller.submissions.isEmpty) {
          return const HistoryEmptyState();
        }

        // ✅ 3. DATA
        return ListView.separated(
          padding: EdgeInsets.all(16.w),
          itemCount: controller.submissions.length,
          separatorBuilder: (_, __) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            return TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: Duration(milliseconds: 400 + (index * 80)),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 20 * (1 - value)),
                    child: child,
                  ),
                );
              },
              child: HistoryItemCard(
                item: controller.submissions[index],
              ),
            );
          },
        );
      },
    );
  }
}
