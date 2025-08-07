import 'package:flutter/material.dart';

class CameraControls extends StatelessWidget {
  final bool isPhotoTaken;
  final bool hasCapturedPhotos;
  final VoidCallback onTakePhoto;
  final VoidCallback onShowUploadOptions;
  final double currentZoom;
  final Function(double) onZoomChanged;

  const CameraControls({
    super.key,
    required this.isPhotoTaken,
    required this.hasCapturedPhotos,
    required this.onTakePhoto,
    required this.onShowUploadOptions,
    required this.currentZoom,
    required this.onZoomChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            // Zoom indicator and controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Zoom out button
                GestureDetector(
                  onTap: () {
                    final newZoom = (currentZoom - 0.5).clamp(0.5, 10.0);
                    onZoomChanged(newZoom);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                
                const SizedBox(width: 20),
                
                // Zoom indicator
                GestureDetector(
                  onTap: () {
                    // Cycle through common zoom levels
                    final zoomLevels = [0.5, 1.0, 2.0, 5.0, 10.0];
                    final currentIndex = zoomLevels.indexOf(currentZoom);
                    final nextIndex = (currentIndex + 1) % zoomLevels.length;
                    onZoomChanged(zoomLevels[nextIndex]);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${currentZoom.toStringAsFixed(1)}x',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(width: 20),
                
                // Zoom in button
                GestureDetector(
                  onTap: () {
                    final newZoom = (currentZoom + 0.5).clamp(0.5, 10.0);
                    onZoomChanged(newZoom);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Camera controls - horizontal layout
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Gallery button (left)
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A1724),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.photo_library,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                
                // Shutter button (center)
                GestureDetector(
                  onTap: onTakePhoto,
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
                
                // Confirm button (right)
                GestureDetector(
                  onTap: onShowUploadOptions,
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0177DE),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 