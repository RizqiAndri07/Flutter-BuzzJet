import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/token_storage.dart';

class ProfileService {
  final String baseUrl = 'http://backend-buzjet-revamp.test/api';
  final TokenStorage _tokenStorage = TokenStorage();

  Future<Map<String, dynamic>> getProfile() async {
    final token = await _tokenStorage.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/profile'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load profile');
  }
}
