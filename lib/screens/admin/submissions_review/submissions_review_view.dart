import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'submissions_review_controller.dart';
import 'widgets/submissions_top_section.dart';
import 'widgets/submissions_list_section.dart';

class SubmissionsReviewView extends StatelessWidget {
  const SubmissionsReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: GetBuilder<SubmissionsReviewController>(
          builder: (controller) {
            return Column(
              children: [
       
                const SubmissionsTopSection(),


               
                const Expanded(
                  child: SubmissionsListSection(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
