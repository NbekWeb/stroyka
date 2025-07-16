import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../components/index.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _handleLogout(BuildContext context) async {
    await AuthService.logout();
    if (context.mounted) {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return TimeWrap(
      header: PageHeader(
        title: 'Stroyka',
        trailing: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => _handleLogout(context),
        ),
      ),
      content: Column(
        children: [
          const SizedBox(height: 40),
          const Text(
            'Timeline',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 60),
          // Your content here (without TimelineWidget as it's now fixed at bottom)
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
