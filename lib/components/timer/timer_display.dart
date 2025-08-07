import 'package:flutter/material.dart';

class TimerDisplay extends StatelessWidget {
  final int totalSeconds;

  const TimerDisplay({
    super.key,
    required this.totalSeconds,
  });

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.w500,
          color: Colors.white,
          fontFamily: 'monospace',
        ),
        children: [
          TextSpan(text: _formatTime(totalSeconds).substring(0, 6)), // 00:00:
          TextSpan(
            text: _formatTime(totalSeconds).substring(6), // 00
            style: const TextStyle(
              color: Color(0x80FFFFFF), // white/50
            ),
          ),
        ],
      ),
    );
  }
} 