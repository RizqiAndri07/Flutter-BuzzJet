import 'package:flutter/material.dart';
import 'package:buzz_jet/screen/dashboard/home.dart';
import 'package:buzz_jet/screen/dashboard/profile.dart';
import 'package:buzz_jet/screen/dashboard/setting.dart';
import 'package:buzz_jet/screen/dashboard/mytrip.dart';

class Layout extends StatefulWidget {
  const Layout({super.key}); // Make sure constructor is const

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  // Indeks halaman aktif
  int _selectedIndex = 0;

  // Daftar widget halaman
  final List<Widget> _pages = [
    HomePage(),
    MyTripPage(),
    ProfilePage(),
    SettingsPage(),
  ];

  // Fungsi untuk mengubah indeks
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/BuzJetLogo.png',
          height: 40, // Sesuaikan tinggi gambar sesuai kebutuhan Anda
        ),
      ),
      body: _pages[_selectedIndex], // Konten berdasarkan indeks aktif
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color.fromARGB(255, 8, 69, 120),
        unselectedItemColor: Colors.blue.withOpacity(0.6),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'My Trip',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
