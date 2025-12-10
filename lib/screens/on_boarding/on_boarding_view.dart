import 'package:eco_cycle/screens/on_boarding/on_boarding_controller.dart';
import 'package:eco_cycle/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OnBoardingController>(
        builder: (controller) {
          return Column(
            children: [
              Visibility(
                visible: controller.currentIndex != 2,
                child: Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    child: Text('Skip', style: AppTextStyles.body),
                    onPressed: controller.skip,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
