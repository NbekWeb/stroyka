import 'package:flutter/material.dart';

class FlagWidget extends StatelessWidget {
  final double width;
  final double height;

  const FlagWidget({
    super.key,
    this.width = 32,
    this.height = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: Image.asset(
          'assets/img/flag.png',
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
} 