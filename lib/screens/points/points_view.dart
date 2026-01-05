import 'package:eco_cycle/widgets/app_app_bar.dart';
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppAppBar(title: "Points & Rewards", withBorder: false,),
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
