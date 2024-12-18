import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  void signup(String email, String password) async {
    Uri uri = Uri.parse('http://backend-buzjet-api.test/api/register');

    var response = await http.post(uri,
        body:
            json.encode({"email": email, "password": password, "token": true}));
    print(json.decode(response.body));
  }
}
