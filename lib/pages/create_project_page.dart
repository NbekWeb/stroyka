import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateProjectPage extends StatefulWidget {
  const CreateProjectPage({super.key});

  @override
  State<CreateProjectPage> createState() => _CreateProjectPageState();
}

class _CreateProjectPageState extends State<CreateProjectPage> {
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _regNoController = TextEditingController();
  final TextEditingController _clientRepController = TextEditingController();

  @override
  void dispose() {
    _companyNameController.dispose();
    _regNoController.dispose();
    _clientRepController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF5FB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    // Close button
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(5, 45, 80, 0.05),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(25),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.close,
                          color:  Color.fromRGBO(5, 45, 80, 0.5),
                          size: 16,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Create & select project',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    // Check button
                    GestureDetector(
                      onTap: () {
                        // Handle project creation
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0785F4),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF0785F4).withAlpha(100),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Address
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text(
                  'Gruvrisvägen 70, 791 61 Falun',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF052D50),
                    height: 1.2,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Project details section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Location
                    _buildDetailCard(
                      icon: 'assets/icon/locflagb.svg',
                      title: 'Location',
                      onTap: () {
                        // Handle location selection
                      },
                    ),
                    const SizedBox(height: 12),

                    // People
                    _buildDetailCard(
                      icon: 'assets/icon/people.svg',
                      title: 'People',
                      onTap: () {
                        // Handle people selection
                      },
                    ),
                    const SizedBox(height: 12),

                    // Project manager
                    _buildDetailCard(
                      icon: 'assets/icon/neck.svg',
                      title: 'Project manager',
                      onTap: () {
                        // Handle project manager selection
                      },
                    ),
                    const SizedBox(height: 12),

                    // Tags
                    _buildDetailCard(
                      icon: null,
                      title: 'Tags',
                      onTap: () {
                        // Handle tags selection
                      },
                    ),

                    const SizedBox(height: 30),

                    // Company name
                    _buildInputField(
                      controller: _companyNameController,
                      placeholder: 'Company name',
                    ),
                    const SizedBox(height: 16),

                    // Reg. No
                    _buildInputField(
                      controller: _regNoController,
                      placeholder: 'Reg. No',
                    ),
                    const SizedBox(height: 16),

                    // Client representative
                    _buildInputField(
                      controller: _clientRepController,
                      placeholder: 'Client representative',
                    ),
                    
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailCard({
    String? icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 58,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(25),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Row(
            children: [
              if (icon != null) ...[
                SvgPicture.asset(
                  icon,
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF052D50),
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 16),
              ],
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 5, 45, 80),
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: const Color(0xFF052D50).withOpacity(0.5),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String placeholder,
  }) {
    return Container(
      width: double.infinity,
      height: 58,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 16,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 19),
          isDense: true,
        ),
      ),
    );
  }
} 