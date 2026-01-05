import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../points_controller.dart';
import '../../../constants/app_colors.dart';
class RedeemPointsCard extends GetView<PointsController> {
  const RedeemPointsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Redeem Points',
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 12.h),

          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: theme.colorScheme.primary.withOpacity(0.4),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _FieldLabel('Enter Points', theme),
                _InputField(
                  controller: controller.pointsController,
                  hint: '200',
                  theme: theme,
                ),

                SizedBox(height: 12.h),

                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '≈ \$${controller.cashValue.toStringAsFixed(2)}',
                    style: theme.textTheme.bodySmall,
                  ),
                ),

                SizedBox(height: 16.h),

                _FieldLabel('IBAN', theme),
                _InputField(
                  controller: controller.ibanController,
                  hint: 'PS92 PIBC ...',
                  theme: theme,
                ),

                SizedBox(height: 12.h),

                _FieldLabel('SWIFT', theme),
                _InputField(
                  controller: controller.swiftController,
                  hint: 'PIBCPS22XXX',
                  theme: theme,
                ),

                SizedBox(height: 18.h),

                SizedBox(
                  width: double.infinity,
                  height: 44.h,
                  child: ElevatedButton(
                    onPressed: controller.redeemPoints,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Convert',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final ThemeData theme;

  const _InputField({
    required this.controller,
    required this.hint,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.4),
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: TextField(
        controller: controller,
        style: theme.textTheme.bodyMedium,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          isDense: true,
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  final ThemeData theme;

  const _FieldLabel(this.text, this.theme);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: theme.textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
