import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'photo_thumbnail.dart';

class CameraHeader extends StatelessWidget {
  final VoidCallback onClose;
  final List<XFile> capturedPhotos;
  final Function(int) onDeletePhoto;

  const CameraHeader({
    super.key,
    required this.onClose,
    required this.capturedPhotos,
    required this.onDeletePhoto,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Close button
            GestureDetector(
              onTap: onClose,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF0A1724),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
            
            // Thumbnail previews (only show when photos are taken)
            if (capturedPhotos.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: capturedPhotos.asMap().entries.map((entry) {
                      int index = entry.key;
                      XFile photo = entry.value;
                      return PhotoThumbnail(
                        photo: photo,
                        onDelete: () => onDeletePhoto(index),
                      );
                    }).toList(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
} 