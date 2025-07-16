import 'package:flutter/material.dart';

class LoginFormStyles {
  // Text styles
  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  static const TextStyle countryCodeTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.black87,
  );

  static const TextStyle inputTextStyle = TextStyle(fontSize: 16);

  static const TextStyle errorTextStyle = TextStyle(
    color: Colors.red,
    fontSize: 14,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  // Container styles
  static BoxDecoration get inputContainerDecoration => BoxDecoration(
    color: const Color(0xFFE1F4FF),
    borderRadius: BorderRadius.circular(100),
    border: Border.all(color: const Color(0xFFE1F4FF)),
  );

  // Input decoration
  static InputDecoration get textFieldDecoration => InputDecoration(
    hintText: 'Enter phone number',
    border: InputBorder.none,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    isDense: true,
  );

  // Button styles
  static ButtonStyle get elevatedButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black87,
    side: const BorderSide(color: Color(0xFFE1F4FF), width: 1),
    padding: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100),
    ),
    elevation: 2,
  );

  // Sizes
  static const double inputContainerWidth = 297;
  static const double inputContainerHeight = 48;
  static const double buttonWidth = 300;
  static const double buttonHeight = 46;
  static const double loadingIndicatorSize = 20;
  static const double loadingIndicatorStrokeWidth = 2;

  // Padding and spacing
  static const EdgeInsets horizontalPadding = EdgeInsets.symmetric(horizontal: 24.0);
  static const EdgeInsets countryCodePadding = EdgeInsets.symmetric(horizontal: 24);
  static const double titleBottomSpacing = 30;
  static const double errorTopSpacing = 8;
  static const double buttonTopSpacing = 13;

  // Colors
  static const Color loadingIndicatorColor = Colors.blue;
} 