import 'package:flutter/material.dart';
import 'package:buzz_jet/screen/auth/login.dart'; // Import LoginScreen
// import 'package:buzz_jet/screen/layout/mainlayout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(), // Menggunakan LoginScreen sebagai halaman utama
    );
  }
}
