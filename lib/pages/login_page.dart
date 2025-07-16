import 'package:flutter/material.dart';
import '../components/index.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  Future<void> _handleLogin(String phoneNumber) async {
    setState(() {
      _isLoading = true;
    });

    try {
      // For now, always navigate to register page
      if (mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RegisterPage(phoneNumber: phoneNumber),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Status bar space
            const SizedBox(height: 0),
            
            // Cartoon character image
            Expanded(
              flex: 2,
              child: Center(
                child: Image.asset(
                  'assets/img/login.png',
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image,
                              size: 60,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Login image\n(login.png)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            
            // Login form
            Expanded(
              flex: 1,
              child: LoginForm(
                onLogin: _handleLogin,
                isLoading: _isLoading,
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
} 