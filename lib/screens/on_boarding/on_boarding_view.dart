import 'package:eco_cycle/screens/on_boarding/on_boarding_controller.dart';
import 'package:eco_cycle/screens/on_boarding/widgets/on_boarding_item.dart';
import 'package:eco_cycle/styles/text_style.dart';
import 'package:eco_cycle/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';

class OnboardingView extends GetView<OnBoardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<OnBoardingController>(
        builder: (c) {
          return Column(
            children: [

              // Skip Button
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Visibility(
                    visible: c.currentIndex != 2,
                    child: TextButton(
                      onPressed: c.skip,
                      child: Text(
                        "Skip",
                        style: AppTextStyles.body,
                      ),
                    ),
                  ),
                )
              ),

              Expanded(
                child: PageView(
                  controller: c.pageController,
                  onPageChanged: c.onPageChanged,
                  children: const [
                    OnboardingItem(
                      image: onB1,
                      title: "Welcome to EcoCycle App",
                      subtitle: "Save environment and earn",
                    ),
                    OnboardingItem(
                      image: onB2,
                      title: "Help protect the environment",
                      subtitle: "Recycle your waste with us",
                    ),
                    OnboardingItem(
                      image: onB3,
                      title: "Collect points & convert to cash",
                      subtitle: "Start now!",
                    ),
                  ],
                ),
              ),

              // Dots Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: c.currentIndex == index ? 20 : 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: c.currentIndex == index
                          ? AppColors.primary
                          : AppColors.greyLight,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Next Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: c.nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      c.currentIndex == 2 ? "Get Start Now" : "Next",
                      style: AppTextStyles.button,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          );
        },
      ),
    );
  }
}
