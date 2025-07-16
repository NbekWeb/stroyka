import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  static const String _tokenKey = 'access_token';
  
  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    return token != null && token.isNotEmpty;
  }
  
  // Get access token
  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }
  
  // Login user
  static Future<bool> login(String phoneNumber) async {
    try {
      // Simulate API call - replace with actual API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Generate a mock token (replace with actual token from API)
      final token = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';
      
      // Save token to local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_tokenKey, token);
      
      return true;
    } catch (e) {
      // Log error (in production, use proper logging framework)
      debugPrint('Login error: $e');
      return false;
    }
  }
  
  // Logout user
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
} 