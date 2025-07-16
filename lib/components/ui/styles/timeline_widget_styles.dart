import 'package:flutter/material.dart';

class TimelineWidgetStyles {
  // Container styles
  static const double containerHeight = 400;
  static const EdgeInsets containerPadding = EdgeInsets.only(top: 0);
  
  // Timeline positioning
  static const double timelineTopPosition = 240;
  static const double timelineSegmentOffset = -120;
  static const double timelineSegmentSize = 80;
  static const double centerButtonSize = 110;
  
  // Button colors
  static const Color runningButtonColor = Color(0xFFABABAB);
  static const Color stoppedButtonColor = Color(0xFFB7C8B5);
  static const Color buttonIconColor = Colors.white;
  static const double buttonIconSize = 80;
  
  // Shadow styles
  static const BoxShadow buttonShadow = BoxShadow(
    color: Color(0x1F000000), // #0000001F
    blurRadius: 12,
    offset: Offset(0, 4),
    spreadRadius: 0,
  );
  
  // Time display styles
  static const double timeDisplayTopPosition = 10;
  static const double timeDisplayBottomPosition = 20;
  static const EdgeInsets timeDisplayMargin = EdgeInsets.symmetric(horizontal: 20);
  static const EdgeInsets timeDisplayPadding = EdgeInsets.symmetric(horizontal: 20, vertical: 15);
  static const double timeDisplayBorderRadius = 12;
  
  // Time display shadow
  static BoxShadow get timeDisplayShadow => BoxShadow(
    color: Colors.black.withValues(alpha: 0.1),
    blurRadius: 4,
    offset: const Offset(0, 2),
  );
  
  // Text styles
  static const TextStyle totalTimeTextStyle = TextStyle(
    fontSize: 55,
    fontWeight: FontWeight.w300,
    color: Colors.black,
  );
  
  static const TextStyle currentTimeTextStyle = TextStyle(
    fontSize: 14,
    color: Colors.black87,
  );
  
  // Animation values
  static const double visibleOpacity = 1.0;
  static const double hiddenOpacity = 0.0;
  
  // Progress calculation
  static const int maxProgressIndex = 10;
  static const double angleStep = 20.25;
  static const double startAngle = -90;
  static const double rotationAngle = 90;
} 