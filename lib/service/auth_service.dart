import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class AuthService {
  static const String TOKEN_KEY = 'token'; // Changed to match ProfileService
  static SharedPreferences? _prefs;

  // Initialize SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Login method
  static Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://backend-buzjet-api.test/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      debugPrint('Login response status: ${response.statusCode}');
      debugPrint('Login response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == true) {
          final token = responseData['data']['access_token'];
          final success = await saveToken(token);
          debugPrint('Token saved successfully: $success');
          debugPrint('Saved token: $token');
          return success;
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
      final result = await prefs.setString(TOKEN_KEY, token);
      debugPrint('Token saved to SharedPreferences: $result');
      return result;
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
      debugPrint('Retrieved token: $token');
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
