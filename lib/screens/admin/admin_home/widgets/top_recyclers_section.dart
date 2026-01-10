import 'package:eco_cycle/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../admin_home_controller.dart';

class TopRecyclersSection extends StatelessWidget {
  const TopRecyclersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminHomeController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Top Recyclers This Month',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.h),
        
            // ✅ Border container
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: AppColors.primary,
                  width: 1,
                ),
              ),
              child: Column(
                children: controller.topRecyclers.map(
                  (e) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.h),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: _rankColor(e['rank']),
                          child: Text(
                            e['rank'].toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${e['submissions']} submissions',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${e['points']} pts',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ).toList(),
              ),
            ),
          ],
        );
      }
    );
  }

  /// 🎨 Rank color based on position
  Color _rankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.deepPurple; // #1
      case 2:
        return Colors.orangeAccent; // #2
      case 3:
        return Colors.lightGreenAccent; // #3
      case 4:
        return Colors.blueAccent; // #4
      default:
        return Colors.grey; // 5+
    }
  }
}
