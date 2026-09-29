import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_training/core/theme/app_colors.dart';

class CustomTextRich extends StatelessWidget {
  const CustomTextRich({super.key, required this.onTap, required this.firstString, required this.secondString});
  final void Function() onTap;
  final String firstString;
  final String secondString;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: firstString,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white.withValues(alpha: 0.5),
              ),
            ),
            TextSpan(
              text: secondString,
              style: TextStyle(
                fontSize: 15.sp,
                color: AppColors.secondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
