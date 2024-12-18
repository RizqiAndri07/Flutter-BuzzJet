import 'package:http/http.dart' as http;
import 'dart:convert';
import 'auth_service.dart';

class ProfileService {
  static const String baseUrl = 'http://backend-buzjet-api.test/api';

  Future<Map<String, dynamic>> getProfile() async {
    final token = await AuthService.getToken();

    if (token == null) {
      throw Exception('No token found');
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      print('Profile Response status: ${response.statusCode}');
      print('Profile Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['data'] != null &&
            responseData['data']['user'] != null) {
          return responseData['data']['user'];
        }
        throw Exception('Invalid profile data format');
      }
      throw Exception('Failed to load profile: ${response.statusCode}');
    } catch (e) {
      print('Error fetching profile: $e');
      throw Exception('Failed to load profile: $e');
    }
  }

  Future<void> updateProfile(int userId, String name, String email) async {
    final token = await AuthService.getToken();

    if (token == null) {
      throw Exception('No token found');
    }

    try {
      final response = await http.put(
        Uri.parse('$baseUrl/users/$userId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
        }),
      );

      print('Update Profile Response status: ${response.statusCode}');
      print('Update Profile Response body: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Failed to update profile: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating profile: $e');
      throw Exception('Failed to update profile: $e');
    }
  }
}
