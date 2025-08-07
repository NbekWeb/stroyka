import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraPreviewWidget extends StatelessWidget {
  final CameraController? controller;
  final bool isInitialized;

  const CameraPreviewWidget({
    super.key,
    required this.controller,
    required this.isInitialized,
  });

  @override
  Widget build(BuildContext context) {
    if (isInitialized && controller != null) {
      return CameraPreview(controller!);
    } else {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    }
  }
} 