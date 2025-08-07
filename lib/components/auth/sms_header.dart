import 'package:flutter/material.dart';
import 'flag_widget.dart';

class SmsHeader extends StatelessWidget {
  final bool showCodeVerification;
  final VoidCallback onBackPressed;

  const SmsHeader({
    super.key,
    required this.showCodeVerification,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: onBackPressed,
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const FlagWidget(),
        ],
      ),
    );
  }
} 