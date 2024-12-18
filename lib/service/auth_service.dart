import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;  
import 'dart:convert';
class AuthService {
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<List<dynamic>?> fetchData() async {
    final token = await _getToken();
    if (token == null) return null;

    final url = Uri.parse(
        "http://backend-buzjet-api.test/api/data"); // Ganti dengan endpoint Anda
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(
          response.body); // Pastikan ini sesuai dengan format API Anda
    } else {
      return null;
    }
  }
}
