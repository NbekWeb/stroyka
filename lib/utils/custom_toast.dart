import 'package:flutter/material.dart';

class CustomToast {
  static void showTopToast(BuildContext context, String message, {ToastType type = ToastType.error}) {
    OverlayEntry? overlayEntry;
    
    Color backgroundColor;
    IconData icon;
    
    switch (type) {
      case ToastType.success:
        backgroundColor = Colors.green;
        icon = Icons.check_circle_outline;
        break;
      case ToastType.info:
        backgroundColor = Colors.blue;
        icon = Icons.info_outline;
        break;
      case ToastType.error:
      default:
        backgroundColor = Colors.red;
        icon = Icons.error_outline;
        break;
    }
    
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).viewPadding.top + 5, // Status bar pastida 20px masofada
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 200),
            tween: Tween(begin: 1.0, end: 0.0),
            curve: Curves.easeOut,
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(value * MediaQuery.of(context).size.width, 0),
                child: child,
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      message,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => overlayEntry?.remove(),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    // Auto remove after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (overlayEntry?.mounted == true) {
        try {
          overlayEntry?.remove();
        } catch (e) {
          // Ignore error if overlay is already removed
        }
      }
    });
  }
}

enum ToastType {
  success,
  info,
  error,
} 