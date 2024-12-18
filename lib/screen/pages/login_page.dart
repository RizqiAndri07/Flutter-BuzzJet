import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../screen/layout/mainlayout.dart'; // Update import Layout
import '../../service/auth_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    if (_isLoading) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage("Email dan Password harus diisi!");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final success = await AuthService.login(email, password);

      if (success) {
        // Verify token is saved
        final token = await AuthService.getToken();
        debugPrint('Token after login: $token');

        if (!mounted) return;

        // Update navigation to Layout
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Layout()),
        );
      } else {
        if (!mounted) return;
        _showMessage("Login gagal. Periksa email dan password Anda.");
      }
    } catch (e) {
      debugPrint('Login error: $e');
      if (!mounted) return;
      _showMessage("Terjadi kesalahan. Silakan coba lagi.");
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: "Email"),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: "Password"),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    child: Text("Login"),
                  ),
                ],
              ),
            ),
    );
  }
}
