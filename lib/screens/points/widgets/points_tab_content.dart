import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../points_controller.dart';
import 'redeem_points_card.dart';
import 'points_history_list.dart';

class PointsTabContent extends GetView<PointsController> {
  const PointsTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PointsController>(
      builder: (_) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          child: controller.currentTab == PointsTab.redeem
              ? const RedeemPointsCard(
                  key: ValueKey('redeem'),
                )
              : const PointsHistoryList(
                  key: ValueKey('history'),
                ),
        );
      },
    );
  }
}

