import 'package:eco_cycle/constants/app_colors.dart';
import 'package:eco_cycle/screens/home/home_controller.dart';
import 'package:eco_cycle/screens/home/widgets/home_header.dart';
import 'package:eco_cycle/screens/home/widgets/total_points_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class HomeTopSection extends StatelessWidget {
  const HomeTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.primary,
      //padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        children: [
          const HomeHeaderWidget(),
          const SizedBox(height: 12),
          GetBuilder<HomeController>(
            builder: (controller) {
              return TotalPointsCard(
                totalPoints: controller.pointsBalance,
                weeklyPoints: controller.weeklyPoints,
              );
            },
          ),
        ],
      ),
    );
  }
}
