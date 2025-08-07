import 'package:flutter/material.dart';

class TimelineProgress extends StatelessWidget {
  final int progressIndex;
  final int maxElements;

  const TimelineProgress({
    super.key,
    required this.progressIndex,
    this.maxElements = 10,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(maxElements, (index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: Container(
              width: 20,
              height: 40,
              decoration: BoxDecoration(
                color: index < progressIndex 
                    ? const Color(0xFF0177DE) // Active timeline element
                    : const Color(0xFF0177DE).withAlpha((255 * 0.2).toInt()), // Inactive timeline element (20%)
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          );
        }),
      ),
    );
  }
} 