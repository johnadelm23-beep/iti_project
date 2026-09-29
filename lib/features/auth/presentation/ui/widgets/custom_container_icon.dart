import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_training/core/theme/app_colors.dart';

class CustomContainerIcon extends StatelessWidget {
  const CustomContainerIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
                width: 64.w,
                height: 64.w,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.25),
                  ),
                ),
                child: Icon(
                  Icons.movie_creation_outlined,
                  size: 30.sp,
                  color: AppColors.primary,
                ),
              );
  }
}