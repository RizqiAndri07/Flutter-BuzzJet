import 'package:flutter/material.dart';
import '../screen/pages/detailPackage.dart'; // Pastikan Anda mengimpor halaman detail

class CardPackage extends StatelessWidget {
  const CardPackage({
    super.key,
    required this.packages,
  });

  final List packages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: packages.length,
      itemBuilder: (context, index) {
        final package = packages[index];
        final imageUrl =
            'http://backend-buzjet-api.test/api/packages/${package['id']}/image';
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
            child: Card(
              margin: const EdgeInsets.all(8.0),
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
                title: Text(package['name']),
                subtitle: Text(package['description']),
              ),
            ),
          ),
        );
      },
    );
  }
}
