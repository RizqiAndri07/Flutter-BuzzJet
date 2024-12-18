import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:buzz_jet/screen/pages/detailPackage.dart';

class CardPackage extends StatelessWidget {
  final List packages;

  const CardPackage({super.key, required this.packages});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: packages.length,
      itemBuilder: (context, index) {
        final package = packages[index];
        final imageUrl =
            'http://backend-buzjet-revamp.test/api/packages/${package['id']}/image';
        print('Attempting to load image from: $imageUrl'); // Debug print

        return MouseRegion(
          onEnter: (_) => print('Hovering over card'), // Debug print
          onExit: (_) => print('Not hovering over card'), // Debug print
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPackage(package: package),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.white, Colors.blue], // Warna gradasi
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Card(
                color: Colors.transparent, // Buat Card transparan
                elevation: 0, // Hilangkan bayangan Card
                child: ListTile(
                  // leading: ClipRRect(
                  //   borderRadius: BorderRadius.circular(8.0),
                  //   child: Image.network(
                  //     imageUrl,
                  //     fit: BoxFit.cover,
                  //     width: 50.0,
                  //     height: 50.0,
                  //   ),
                  // ),
                  title: Text(
                    package['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold, // Membuat font bold
                    ),
                  ),
                  subtitle: Text(package['description']),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
