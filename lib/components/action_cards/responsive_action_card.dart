import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponsiveActionCard extends StatelessWidget {
  final String iconPath;
  final String label;
  final VoidCallback? onTap;

  const ResponsiveActionCard({
    super.key,
    required this.iconPath,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 88.h,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF0A1724),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 24.w,
              height: 24.h,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            SizedBox(height: 10.h),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResponsiveActionCardData {
  final String iconPath;
  final String label;
  final VoidCallback? onTap;

  ResponsiveActionCardData({
    required this.iconPath,
    required this.label,
    this.onTap,
  });
} 