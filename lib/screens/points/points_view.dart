import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/app_colors.dart';
import 'points_controller.dart';
import 'widgets/points_balance_card.dart';
import 'widgets/points_tabs.dart';
import 'widgets/points_tab_content.dart';

class PointsView extends GetView<PointsController> {
  const PointsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          'Points & Rewards',
          style: TextStyle(fontSize: 16.sp,color: Colors.white,fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
                leading: Icon(Icons.arrow_back, size: 22.sp,color: Colors.white),

      ),
      body: SingleChildScrollView(
        child: Column(
          children:  [
            PointsBalanceCard(),
            SizedBox(height: 16),
            PointsTabs(),
            SizedBox(height: 16),
            PointsTabContent(),
          ],
        ),
      ),
    );
  }
}
