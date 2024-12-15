import 'package:flutter/material.dart';

class CardPackage extends StatelessWidget {
  const CardPackage({
    super.key,
    required this.packages,
  });

  final List packages;
  final String baseUrl =
      'http://backend-buzjet-api.test/api/destinations/'; // URL dasar API

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: packages.length,
      itemBuilder: (context, index) {
        // Bangun URL gambar secara dinamis menggunakan ID
        String imageUrl = '$baseUrl${packages[index]['id']}/image';
        // Print URL gambar untuk debugging
        print('Image URL: $imageUrl');

        return Card(
          child: ListTile(
            leading: packages[index]['img'] != null &&
                    packages[index]['img'].isNotEmpty
                ? Image.network(
                    imageUrl,
                    errorBuilder: (context, error, stackTrace) {
                      print(
                          'Failed to load image: $imageUrl'); // Print error message
                      return Icon(Icons.broken_image);
                    },
                  )
                : Icon(Icons.image_not_supported),
            title: Text(packages[index]['name']),
            subtitle: Text(packages[index]['description']),
          ),
        );
      },
    );
  }
}
