import 'package:eco_cycle/widgets/app_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/app_colors.dart';
import 'history_controller.dart';
import 'widgets/history_summary_section.dart';
import 'widgets/history_list.dart';
class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppAppBar(title: "Submission History"),

      body: GetBuilder<HistoryController>(
        init: HistoryController(),
        builder: (_) {
          return const Column(
            children: [
              HistorySummarySection(),
              Expanded(child: HistoryList()),
            ],
          );
        },
      ),
    );
  }
}
