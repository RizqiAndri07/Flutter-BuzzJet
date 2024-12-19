import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'PaymentPage.dart';
import '../../service/auth_service.dart';

class DetailPackage extends StatelessWidget {
  final Map package;

  const DetailPackage({super.key, required this.package});

  Future<void> createBooking(BuildContext context, int seats) async {
    try {
      // Ambil token dari AuthService
      final String? token = await AuthService.getToken();

      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Silakan login terlebih dahulu')),
        );
        // TODO: Navigate to login page
        return;
      }

      final response = await http.post(
        Uri.parse('http://backend-buzjet-api.test/api/bookings'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'package_id': package['id'],
          'seats': seats,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Booking berhasil dibuat!')),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentPage(
              totalPrice: responseData['data']['total_price'].toDouble(),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal membuat booking: ${response.body}')),
        );
      }
    } catch (e) {
      print('Error creating booking: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat currencyFormat =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(
        title: Text(package['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.asset(
                'assets/pantai.jpg',
                width: double.infinity,
                height: 200.0,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              package['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(package['description']),
            SizedBox(height: 16),
            Text(
                'Price: ${currencyFormat.format(double.parse(package['price']))}'),
            SizedBox(height: 8),
            Text('Duration: ${package['duration']} days'),
            SizedBox(height: 8),
            Text('Night: ${package['night']} nights'),
            SizedBox(height: 8),
            Text('Capacity: ${package['capacity']} people'),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      int quantity = 1;
                      double price = double.parse(package['price']);
                      int maxSeats = 10; // Maximum seats as per API validation
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            title: Text('Order Now'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Price: ${currencyFormat.format(price)}'),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Quantity:'),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.remove),
                                          onPressed: () {
                                            if (quantity > 1) {
                                              setState(() {
                                                quantity--;
                                              });
                                            }
                                          },
                                        ),
                                        Text('$quantity'),
                                        IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            if (quantity < maxSeats) {
                                              setState(() {
                                                quantity++;
                                              });
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Text(
                                    'Total Price: ${currencyFormat.format(quantity * price)}'),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  createBooking(context, quantity);
                                },
                                child: Text('Order'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 16.0,
                  ),
                  textStyle: TextStyle(fontSize: 18),
                  foregroundColor: Colors.white,
                ),
                child: Text('Order Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
