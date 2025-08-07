import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final String phoneNumber;

  const RegisterPage({super.key, required this.phoneNumber});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  void _handleConnect() {
    Navigator.of(context).pushReplacementNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 48),
              Container(
                constraints: const BoxConstraints(
                  maxHeight: 374,
                ),
                width: double.infinity,
                child: Image.asset(
                  'assets/img/reg.jpg',
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Contact the site manager to register your phone number.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: 297,
                height: 48,
                child: ElevatedButton(
                  onPressed: _handleConnect,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFE1E1),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    '',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 32), // pastdan ham joy qoldirish uchun
            ],
          ),
        ),
      ),
    );
  }
} 