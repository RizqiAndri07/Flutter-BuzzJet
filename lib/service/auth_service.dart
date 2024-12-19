import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
<<<<<<< HEAD
=======
import 'package:flutter/foundation.dart';
>>>>>>> 6f4b192478237d37e8a165a35ae4174e26ec5e47
import 'dart:convert';

class AuthService {
  static const String TOKEN_KEY = 'auth_token';
  static SharedPreferences? _prefs;

  // Initialize SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Login method
  static Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://backend-buzjet-revamp.test/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

<<<<<<< HEAD
    final url = Uri.parse(
        "http://backend-buzjet-api.test/api/login"); // Ganti dengan endpoint Anda
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
=======
      debugPrint('Login response status: ${response.statusCode}');
      debugPrint('Login response body: ${response.body}');
>>>>>>> 6f4b192478237d37e8a165a35ae4174e26ec5e47

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == true) {
          final token = responseData['data']['access_token'];
          await saveToken(token);
          return true;
        }
      }
      return false;
    } catch (e) {
      debugPrint('Login error: $e');
      return false;
    }
  }

  // Save token
  static Future<bool> saveToken(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(TOKEN_KEY, token);
      return true;
    } catch (e) {
      debugPrint('Error saving token: $e');
      return false;
    }
  }

  // Get token - make it static to be accessible from anywhere
  static Future<String?> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(TOKEN_KEY);
      return token;
    } catch (e) {
      debugPrint('Error getting token: $e');
      return null;
    }
  }

  // Logout
  static Future<bool> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(TOKEN_KEY);
      return true;
    } catch (e) {
      debugPrint('Logout error: $e');
      return false;
    }
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // Fetch data with authentication
  static Future<dynamic> fetchWithAuth(String url) async {
    try {
      final token = await getToken();
      if (token == null) return null;

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return null;
    } catch (e) {
      debugPrint('Fetch error: $e');
      return null;
    }
  }
}
