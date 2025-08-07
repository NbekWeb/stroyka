import 'package:flutter/material.dart';
import '../../pages/timeline/home_page.dart';

class UploadModal extends StatelessWidget {
  final int photoCount;
  final VoidCallback onClose;

  const UploadModal({
    super.key,
    required this.photoCount,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0A1724),
      child: Column(
        children: [
          const Spacer(),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                // Handle bar
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Title
                Text(
                  'Upload $photoCount photo${photoCount > 1 ? 's' : ''} to',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Upload options
                ..._buildUploadOptions(context),
                
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildUploadOptions(BuildContext context) {
    final options = [
      {'icon': Icons.access_time, 'title': 'Tracker'},
      {'icon': Icons.folder, 'title': 'Project'},
      {'icon': Icons.list, 'title': 'Task'},
      {'icon': Icons.chat_bubble, 'title': 'Chat'},
    ];

    return options.map((option) => 
      GestureDetector(
        onTap: () {
          onClose();
          
          // Navigate back to home page
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false,
          );
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Icon(
                option['icon'] as IconData,
                color: Colors.black87,
                size: 24,
              ),
              const SizedBox(width: 16),
              Text(
                option['title'] as String,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    ).toList();
  }
} 