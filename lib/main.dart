import 'package:flutter/material.dart';
import 'package:buzz_jet/screen/pages/login_page.dart';
import 'package:buzz_jet/service/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.init();
  runApp(const MyApp());
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
