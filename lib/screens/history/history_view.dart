import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/app_colors.dart';
import 'history_controller.dart';
import 'widgets/history_summary_section.dart';
import 'widgets/history_list.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          'Submission History',
          style: TextStyle(fontSize: 16.sp,color: Colors.white,fontWeight: FontWeight.w600),
        ),
        leading: Icon(Icons.arrow_back, size: 22.sp,color: Colors.white),
      ),
      body: const Column(
        children: [
          HistorySummarySection(),
          Expanded(child: HistoryList()),
        ],
      ),
    );
  }
}
