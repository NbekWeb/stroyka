import 'package:flutter/material.dart';

class PageContainerStyles {
  // Default colors
  static const Color defaultBackgroundColor = Colors.white;
  static const Color defaultBorderColor = Color(0xFFF3F3F3);
  
  // Default border
  static const Border defaultBorder = Border(
    top: BorderSide(color: Color(0xFFF3F3F3), width: 1),
    bottom: BorderSide(color: Color(0xFFF3F3F3), width: 1),
  );
}

class PageHeaderStyles {
  // Text styles
  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  );

  // Default padding
  static const EdgeInsets defaultPadding = EdgeInsets.all(20);
} 