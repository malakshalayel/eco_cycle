import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'points_review_controller.dart';
import 'widgets/points_review_list_section.dart';
import 'widgets/points_review_top_section.dart';

class PointsReviewView extends StatelessWidget {
  const PointsReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: GetBuilder<PointsReviewController>(
          builder: (controller) {
            return Column(
              children: const [
                PointsReviewTopSection(),
                Expanded(
                  child: PointsReviewListSection(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
