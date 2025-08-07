import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const BottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem('assets/icon/home.svg', 'Home', 0),
          _buildNavItem('assets/icon/menu.svg', 'Menu', 1),
        ],
      ),
    );
  }

  Widget _buildNavItem(String iconPath, String label, int index) {
    final isSelected = selectedIndex == index;
    final iconColor = isSelected ? Colors.white : Colors.white.withAlpha((255 * 0.4).toInt()); // 40% opacity
    
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 28,
            height: 28,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Colors.white : Colors.white.withAlpha((255 * 0.4).toInt()), // 40% opacity
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
} 