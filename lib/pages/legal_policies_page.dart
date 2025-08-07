import 'package:flutter/material.dart';
import '../components/index.dart';

class LegalPoliciesPage extends StatefulWidget {
  const LegalPoliciesPage({super.key});

  @override
  State<LegalPoliciesPage> createState() => _LegalPoliciesPageState();
}

class _LegalPoliciesPageState extends State<LegalPoliciesPage> {
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
            'Legal & Policies',
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildIntroText(),
            const SizedBox(height: 24),
            _buildPolicyCard(
              title: 'What data do we collect?',
              items: [
                'Personal information provided during registration (name, phone number, email)',
                'Work-related data such as time logs, project details, and GPS locations (only during working hours, as configured by your employer)',
                'Communication and documents exchanged within the app',
              ],
            ),
            const SizedBox(height: 12),
            _buildPolicyCard(
              title: 'How do we use your data?',
              items: [
                'To provide and improve our services',
                'To facilitate communication and project management between office, foremen, and workers',
                'To comply with legal obligations and improve security',
              ],
            ),
            const SizedBox(height: 12),
            _buildPolicyCard(
              title: 'Data Protection',
              items: [
                'Your data is securely stored both locally and in the cloud',
                'Access is protected by login/password and other secure authentication methods',
                'We do not share your personal information with third parties except as required by law or with your consent',
              ],
            ),
            const SizedBox(height: 12),
            _buildPolicyCard(
              title: 'Your Rights',
              items: [
                'You may request access, correction, or deletion of your personal data at any time',
                'You can contact our support team regarding privacy questions or data removal requests',
              ],
            ),
            const SizedBox(height: 12),
            _buildPolicyCard(
              title: 'Legal Notice',
              items: [
                'By using Bygg App, you agree to our Terms of Service and this Privacy Policy',
                'For more information, please review the full documents',
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroText() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFE1F4FF),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Text(
        'Your privacy is important to us. Bygg App is committed to protecting your personal data and ensuring transparency in how your information is collected, used, and stored.',
        style: TextStyle(fontSize: 15, color: Colors.black, height: 1.2),
      ),
    );
  }

  Widget _buildPolicyCard({required String title, required List<String> items}) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }
} 