import 'package:flutter/material.dart';
import 'dart:math' show pi;
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

  String _getCurrentTime() {
    DateTime now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  String _getCurrentDate() {
    DateTime now = DateTime.now();
    return '${now.year} ${now.month.toString().padLeft(2, '0')}.${now.day.toString().padLeft(2, '0')}';
  }

    @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: TimelineWidgetStyles.containerHeight,
      padding: TimelineWidgetStyles.containerPadding,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Timeline wrapper with progress segments and button
          Positioned(
            top: TimelineWidgetStyles.timelineTopPosition,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Progress segments
                ...List.generate(TimelineWidgetStyles.maxProgressIndex, (index) {
                  final angle = (index * TimelineWidgetStyles.angleStep) + TimelineWidgetStyles.startAngle;
                  return Positioned(
                    child: Transform.rotate(
                      angle: angle * (pi / 180),
                      child: Transform.translate(
                        offset: Offset(0, TimelineWidgetStyles.timelineSegmentOffset),
                        child: Transform.rotate(
                          angle: TimelineWidgetStyles.rotationAngle * (pi / 180),
                          child: Image.asset(
                            index < progressIndex 
                                ? 'assets/img/timeline-green.png'
                                : 'assets/img/timeline.png',
                            width: TimelineWidgetStyles.timelineSegmentSize,
                            height: TimelineWidgetStyles.timelineSegmentSize,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                
                // Center button
                Container(
                  width: TimelineWidgetStyles.centerButtonSize,
                  height: TimelineWidgetStyles.centerButtonSize,
                  decoration: BoxDecoration(
                    color: isRunning ? TimelineWidgetStyles.runningButtonColor : TimelineWidgetStyles.stoppedButtonColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      TimelineWidgetStyles.buttonShadow,
                    ],
                  ),
                  child: IconButton(
                    onPressed: _toggleTimer,
                    icon: isRunning 
                      ? Icon(
                          Icons.stop_rounded,
                          color: TimelineWidgetStyles.buttonIconColor,
                          size: TimelineWidgetStyles.buttonIconSize,
                        )
                      : Image.asset(
                          'assets/icon/play.png',
                          width: TimelineWidgetStyles.buttonIconSize,
                          height: TimelineWidgetStyles.buttonIconSize,
                          color: TimelineWidgetStyles.buttonIconColor,
                        ),
                  ),
                ),
              ],
            ),
          ),
          
          // Total time display with opacity
          Positioned(
            top: TimelineWidgetStyles.timeDisplayTopPosition,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: totalSeconds > 0 ? TimelineWidgetStyles.visibleOpacity : TimelineWidgetStyles.hiddenOpacity,
                              child: Container(
                  margin: TimelineWidgetStyles.timeDisplayMargin,
                  padding: TimelineWidgetStyles.timeDisplayPadding,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(TimelineWidgetStyles.timeDisplayBorderRadius),
                    boxShadow: [
                      TimelineWidgetStyles.timeDisplayShadow,
                    ],
                  ),
                                  child: Center(
                    child: Text(
                      _formatTime(totalSeconds),
                      style: TimelineWidgetStyles.totalTimeTextStyle,
                    ),
                  ),
              ),
            ),
          ),
          
          // Current time and date with opacity
          Positioned(
            bottom: TimelineWidgetStyles.timeDisplayBottomPosition,
            child: Opacity(
              opacity: totalSeconds > 0 ? TimelineWidgetStyles.visibleOpacity : TimelineWidgetStyles.hiddenOpacity,
              child: Text(
                '${_getCurrentTime()} ${_getCurrentDate()}',
                style: TimelineWidgetStyles.currentTimeTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 