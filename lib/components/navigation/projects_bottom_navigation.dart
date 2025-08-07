import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';

class ProjectsBottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final VoidCallback onHomeTap;
  final VoidCallback onMenuTap;
  final VoidCallback onAddTap;

  const ProjectsBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onHomeTap,
    required this.onMenuTap,
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 393,
      height: 115,
      child: Stack(
        children: [
          // Main navigation bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              width: double.infinity, // 100% width
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Home and Menu wrapper
                  Container(
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Home button
                        _buildNavItem(
                          icon: Icons.home,
                          label: 'Home',
                          isSelected: selectedIndex == 0,
                          onTap: onHomeTap,
                        ),
                        
                        // 20px gap between Home and Menu
                        SizedBox(width: 20.w),
                        
                        // Menu button
                        _buildNavItem(
                          icon: Icons.grid_view,
                          label: 'Menu',
                          isSelected: selectedIndex == 1,
                          onTap: onMenuTap,
                        ),
                      ],
                    ),
                  ),
                  
                  // 15px gap between Home/Menu and Plus
                  SizedBox(width: 15.w),
                  
                  // Plus button
                  GestureDetector(
                    onTap: onAddTap,
                    child: Container(
                      width: 60.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0177DE),
                        borderRadius: BorderRadius.circular(30.r),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF0177DE).withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 46.w, vertical: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF0177DE) : Colors.grey[600],
              size: 24.sp,
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: isSelected ? const Color(0xFF0177DE) : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 