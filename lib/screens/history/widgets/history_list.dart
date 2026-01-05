import 'package:eco_cycle/screens/history/model/submission_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../history_controller.dart';
import 'history_item_card.dart';
import 'history_empty_state.dart';

import 'history_loading_state.dart';
class HistoryList extends GetView<HistoryController> {
  const HistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SubmissionModel>>(
      stream: controller.historyStream(),
      builder: (context, snapshot) {
        // 🔄 Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const HistoryItemSkeleton();
        }

        // ❌ Error
        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        }

        final data = snapshot.data ?? [];

        // 📭 Empty
        if (data.isEmpty) {
          return const HistoryEmptyState();
        }

        // ✅ Data
        return ListView.separated(
          padding: EdgeInsets.all(16.w),
          itemCount: data.length,
          separatorBuilder: (_, __) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            return HistoryItemCard(item: data[index]);
          },
        );
      },
    );
  }
}
