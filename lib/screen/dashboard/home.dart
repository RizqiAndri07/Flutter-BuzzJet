import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:buzz_jet/widget/CardPackage.dart'; // Tambahkan impor ini

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List packages = [];

  @override
  void initState() {
    super.initState();
    fetchPackages();
  }

  Future<void> fetchPackages() async {
    final response = await http
        .get(Uri.parse('http://backend-buzjet-api.test/api/packages'));
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
      body: CardPackage(packages: packages),
    );
  }
}
