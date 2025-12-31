import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';
import 'navigation_controller.dart';

// Pages
import '../home/home_view.dart';
import '../submission/submission_view.dart';
import '../history/history_view.dart';
import '../points/points_view.dart';
import '../profile/profile_view.dart';

class NavigationView extends GetView<NavigationController> {
  const NavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      builder: (c) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: IndexedStack(
            index: c.currentIndex,
            children: const [
              HomeView(),
              SubmissionView(),
              HistoryView(),
              PointsView(),
              ProfileView(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: c.currentIndex,
            onTap: c.changeTab,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.upload_outlined),
                label: 'Submission',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'history',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.card_giftcard),
                label: 'points',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
