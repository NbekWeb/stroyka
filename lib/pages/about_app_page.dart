import 'package:flutter/material.dart';
import '../components/index.dart';

class AboutAppPage extends StatefulWidget {
  const AboutAppPage({super.key});

  @override
  State<AboutAppPage> createState() => _AboutAppPageState();
}

class _AboutAppPageState extends State<AboutAppPage> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      header: _buildHeader(context),
      content: _buildContent(),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(23),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 4),
                    blurRadius: 12,
                    color: const Color(0x1F000000),
                  ),
                ],
              ),
              child: const Icon(
                Icons.chevron_left,
                color: Colors.black87,
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'About the App',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _buildDescriptionBox(),
          const SizedBox(height: 24),
          const Text(
            'The app allows you to:',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 15),
          _buildFeatureCard(
            icon: Icons.location_on,
            text:
                'Track working hours both manually and automatically using GPS.',
          ),
          const SizedBox(height: 12),
          _buildFeatureCard(
            icon: Icons.description,
            text:
                'Receive and send drawings, tasks, and important documents between the office, foremen, and workers.',
          ),
          const SizedBox(height: 12),
          _buildFeatureCard(
            icon: Icons.campaign,
            text:
                'Manage projects efficiently, receive timely notifications about new tasks, changes, and possible violations on site.',
          ),
          const SizedBox(height: 12),
          _buildFeatureCard(
            icon: Icons.visibility,
            text:
                'Ensure transparency and control over all construction site activities',
          ),
          const SizedBox(height: 24),
          _buildInfoText(),
          const Spacer(),
          Center(child: _buildFooter()),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDescriptionBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFE1F4FF),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Text(
        'Bygg App is a modern solution for construction project management and work hour tracking on construction sites.',
        style: TextStyle(fontSize: 15, color: Colors.black, height: 1.2),
      ),
    );
  }

  Widget _buildFeatureCard({required IconData icon, required String text}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 8,
            color: Colors.black.withValues(alpha: 0.1),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bygg App is available for Android and iOS, protected by modern authentication methods, and fully complies with privacy and data security standards.',
          style: TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.w300,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'If you have any questions or suggestions, please contact our support team through the settings menu.',
          style: TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.w300,
            height: 1.1,
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        const Text(
          'Version: 1.0',
          style: TextStyle(fontSize: 10,fontWeight: FontWeight.w300, color: Colors.black),
        ),
        const SizedBox(height: 4),
        const Text(
          'Developer: Bygg Hub',
          style: TextStyle(fontSize: 10,fontWeight: FontWeight.w300, color: Colors.black),
        ),
        const SizedBox(height: 4),
        const Text(
          'Contact: support@byggapp.com',
          style: TextStyle(fontSize: 10,fontWeight: FontWeight.w300, color: Colors.black),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
