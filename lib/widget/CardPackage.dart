import 'package:flutter/material.dart';

class CardPackage extends StatelessWidget {
  const CardPackage({
    super.key,
    required this.packages,
  });

  final List packages;
  final String specificImageUrl =
      'http://backend-buzjet-revamp.test/api/destinations/1/image';

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: packages.length,
      itemBuilder: (context, index) {
        print(
            'Attempting to load image from: $specificImageUrl'); // Debug print

        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: Image.network(
                specificImageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const SizedBox(
                    width: 60,
                    height: 60,
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  print('Error loading image: $error'); // Debug print
                  return const Icon(Icons.error_outline, size: 60);
                },
              ),
            ),
            title: Text(packages[index]['name'] ?? 'No Name'),
            subtitle: Text('Package ${index + 1}'),
          ),
        );
      },
    );
  }
}