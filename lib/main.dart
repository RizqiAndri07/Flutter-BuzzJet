import 'package:flutter/material.dart';
import 'package:buzz_jet/screen/layout/mainlayout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Layout(), // Menggunakan Layout sebagai halaman utama
    );
  }
}
