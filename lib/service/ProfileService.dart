import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
<<<<<<< HEAD
  final String baseUrl = 'http://backend-buzjet-api.test/api';
=======
  final String baseUrl = 'http://backend-buzjet-revamp.test/api';
  final TokenStorage _tokenStorage = TokenStorage();
>>>>>>> 6f4b192478237d37e8a165a35ae4174e26ec5e47

  Future<Map<String, dynamic>> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception('No token found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/profile'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData['data']['user'];
    }
    throw Exception('Failed to load profile');
  }
}
