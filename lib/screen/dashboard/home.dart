import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:buzz_jet/widget/CardPackage.dart'; // Tambahkan impor ini

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List packages = [];
  String? token;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _getToken(); // Ambil token dari SharedPreferences
    if (token != null) {
      fetchPackages(); // Fetch data hanya jika token tersedia
    }
  }

  Future<void> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token'); // Ambil token yang disimpan
    });
  }

  Future<void> fetchPackages() async {
    final response = await http.get(
      Uri.parse('http://backend-buzjet-revamp.test/api/packages'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Tambahkan token ke header
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        packages = json.decode(response.body)['data'];
      });
    } else {
      throw Exception('Failed to load packages');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: token == null
          ? Center(child: CircularProgressIndicator())
          : CardPackage(packages: packages),
    );
  }

  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // Hapus token dari penyimpanan
    Navigator.pushReplacementNamed(context, '/'); // Kembali ke halaman login
  }
}
