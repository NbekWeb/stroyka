import 'package:flutter/material.dart';
import 'dart:async';
import 'styles/timeline_widget_styles.dart';

class TimelineWidget extends StatefulWidget {
  const TimelineWidget({super.key});

  @override
  State<TimelineWidget> createState() => _TimelineWidgetState();
}

class _TimelineWidgetState extends State<TimelineWidget> {
  bool isRunning = false;
  int totalSeconds = 0;
  int currentSeconds = 0;
  Timer? _timer;
  int progressIndex = 0;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _toggleTimer() {
    if (isRunning) {
      _stopTimer();
    } else {
      _startTimer();
    }
  }

  void _startTimer() {
    setState(() {
      isRunning = true;
      if (totalSeconds == 0) {
        totalSeconds = 0;
        currentSeconds = 0;
        progressIndex = 0;
      }
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        currentSeconds++;
        totalSeconds++;
        // Progress based on total hours
        int totalHours = (totalSeconds / 3600).floor();
        progressIndex = totalHours;
        if (progressIndex > TimelineWidgetStyles.maxProgressIndex) progressIndex = TimelineWidgetStyles.maxProgressIndex;
      });
    });
  }

  void _stopTimer() {
    setState(() {
      isRunning = false;
    });
    _timer?.cancel();
  }

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: TimelineWidgetStyles.containerHeight,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF00203A), // #00203A
            Color(0xFF000509), // #000509
          ],
          stops: [0.0385, 0.2163],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Timer display
          Text(
            _formatTime(totalSeconds),
            style: const TextStyle(
              fontSize: 72,
              fontWeight: FontWeight.w300,
              color: Colors.white,
              fontFamily: 'monospace',
            ),
          ),
          
          const SizedBox(height: 40),
          
          // Timeline with pill-shaped elements
          Container(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(TimelineWidgetStyles.maxProgressIndex, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: Container(
                    width: 19.3,
                    height: 40,
                    decoration: BoxDecoration(
                      color: index < progressIndex 
                          ? const Color(0xFF0177DE).withOpacity(0.8) // Active timeline element
                          : const Color(0xFF0177DE).withOpacity(0.2), // Inactive timeline element
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                );
              }),
            ),
          ),
          
          const SizedBox(height: 40),
          
          // Play/Stop button
          GestureDetector(
            onTap: _toggleTimer,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFF0177DE),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0177DE).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(
                isRunning ? Icons.stop : Icons.play_arrow,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 