  import 'package:eco_cycle/screens/submission/widgets/location_widget.dart';
  import 'package:eco_cycle/screens/submission/widgets/material_type_widget.dart';
  import 'package:eco_cycle/screens/submission/widgets/quantity_widget.dart';
  import 'package:eco_cycle/screens/submission/widgets/submit_button_widget.dart';
  import 'package:eco_cycle/screens/submission/widgets/upload_item_widget.dart';
import 'package:eco_cycle/widgets/app_app_bar.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:get/get.dart';

  import 'submission_controller.dart';

  class SubmissionView extends GetView<SubmissionController> {
    const SubmissionView({super.key});

    @override
    Widget build(BuildContext context) {
      final theme = Theme.of(context);

      return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
appBar : AppAppBar(title: "Submit Recyclable" , withBorder: true,),


        body: GetBuilder<SubmissionController>(
          builder: (c) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Upload Item
                  const UploadItemWidget(),
                  SizedBox(height: 20.h),

                  /// Material
                  const MaterialTypeWidget(),
                  SizedBox(height: 16.h),

                  /// Quantity
                  const QuantityWidget(),
                  SizedBox(height: 16.h),

                  /// Location
                  const LocationWidget(),
                  SizedBox(height: 20.h),

                  /// Submit
                  const SubmitButtonWidget(),
                ],
              ),
            );
          },
        ),
      );
    }
  }
