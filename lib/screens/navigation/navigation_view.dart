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
    final theme = Theme.of(context);

    return GetBuilder<NavigationController>(
      builder: (c) {
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,

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

            backgroundColor: theme.colorScheme.surface,
            selectedItemColor: theme.colorScheme.primary,
            unselectedItemColor: theme.colorScheme.onSurface.withOpacity(0.5),

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
                label: 'History',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.card_giftcard),
                label: 'Points',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
