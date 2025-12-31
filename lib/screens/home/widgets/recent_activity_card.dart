import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentActivityCard extends StatelessWidget {
  const RecentActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
           border: Border.all(
            width: 2,
            color: const Color(0xFF37CE76).withOpacity(0.5),
          ),

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Plastic bottles submitted'),
                Text('+50pts', style: TextStyle(color: Colors.green)),
              ],
            ),
            SizedBox(height: 4),
            const Text(
              '2 hours ago',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(height: 35.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Points redeemed'),
                Text('+50pts', style: TextStyle(color: Colors.red)),
              ],
            ),
            SizedBox(height: 4),
            const Text(
              '1 day ago',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
