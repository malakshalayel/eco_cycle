import 'package:eco_cycle/screens/home/widgets/home_top_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/app_colors.dart';
import 'home_controller.dart';
import 'widgets/home_header.dart';
import 'widgets/total_points_card.dart';
import 'widgets/quick_actions_section.dart';
import 'widgets/recent_activity_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            HomeTopSection(),

             SizedBox(height: 16.h),
             const QuickActionsSection(),
            SizedBox(height: 16.h),
            const RecentActivityCard(),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}

