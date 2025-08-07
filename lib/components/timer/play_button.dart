import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlayButton extends StatelessWidget {
  final bool isRunning;
  final VoidCallback onTap;

  const PlayButton({
    super.key,
    required this.isRunning,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: const Color(0xFF0177DE).withAlpha((255 * 0.2).toInt()), // 20% opacity background
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFF0177DE), // 100% opacity button
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                isRunning ? 'assets/icon/stop.svg' : 'assets/icon/play.svg',
                width: 40,
                height: 40,
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
          ),
        ),
      ),
    );
  }
} 