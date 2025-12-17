import 'package:eco_cycle/screens/submission/widgets/location_widget.dart';
import 'package:eco_cycle/screens/submission/widgets/material_type_widget.dart';
import 'package:eco_cycle/screens/submission/widgets/quantity_widget.dart';
import 'package:eco_cycle/screens/submission/widgets/submit_button_widget.dart';
import 'package:eco_cycle/screens/submission/widgets/upload_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';

import 'submission_controller.dart';

class SubmissionView extends GetView<SubmissionController> {
  const SubmissionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:  Size.fromHeight(74.h),
        child: AppBar(
          backgroundColor: AppColors.primary,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          title: const Text(
            'Submit Recyclable',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          ),
        ),
      ),
      body: GetBuilder<SubmissionController>(
        builder: (c) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Upload Item
                UploadItemWidget(),
                SizedBox(height: 20.h),
                MaterialTypeWidget(),
                SizedBox(height: 16.h),
                QuantityWidget(),
                SizedBox(height: 16.h),
                LocationWidget(),
                SizedBox(height: 20.h),
                SubmitButtonWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}
