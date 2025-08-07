import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class PhotoThumbnail extends StatelessWidget {
  final XFile photo;
  final VoidCallback onDelete;

  const PhotoThumbnail({
    super.key,
    required this.photo,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: FutureBuilder<Widget>(
                future: _buildImageWidget(photo.path),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!;
                  }
                  return Container(
                    color: Colors.grey[800],
                    child: const Icon(
                      Icons.photo,
                      color: Colors.white,
                      size: 20,
                    ),
                  );
                },
              ),
            ),
          ),
          // Red rounded circle badge with close icon
          Positioned(
            top:4,
            right: 4,
            child: GestureDetector(
              onTap: onDelete,
              child: Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Widget> _buildImageWidget(String imagePath) async {
    return Image.file(
      File(imagePath),
      fit: BoxFit.cover,
    );
  }
} 