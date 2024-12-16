import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'PaymentPage.dart';

class DetailPackage extends StatelessWidget {
  final Map package;

  const DetailPackage({super.key, required this.package});

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
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    int quantity = 1;
                    double price = double.parse(package['price']);
                    int capacity = package['capacity'];
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
                                          if (quantity < capacity) {
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
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PaymentPage(
                                        totalPrice: quantity * price),
                                  ),
                                );
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
              child: Text('Order Now'),
            ),
          ],
        ),
      ),
    );
  }
}
