import 'package:flutter/material.dart';
import 'package:buzz_jet/screen/dashboard/home.dart';
import 'package:buzz_jet/screen/dashboard/profile.dart';
import 'package:buzz_jet/screen/dashboard/setting.dart';

class Layout extends StatefulWidget {
  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  // Indeks halaman aktif
  int _selectedIndex = 0;

  // Daftar widget halaman
  final List<Widget> _pages = [
    HomePage(),
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
        title: Text('Buzz Jet'),
      ),
      body: _pages[_selectedIndex], // Konten berdasarkan indeks aktif
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
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
