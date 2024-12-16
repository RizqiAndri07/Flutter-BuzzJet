import 'package:flutter/material.dart';
import 'SuccessPage.dart';

class PaymentPage extends StatefulWidget {
  final double totalPrice;

  const PaymentPage({super.key, required this.totalPrice});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedPaymentMethod = 'DANA';

  @override
  Widget build(BuildContext context) {
    final paymentMethods = ['DANA', 'OVO', 'GoPay', 'Bank Transfer'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Price: Rp ${widget.totalPrice.toStringAsFixed(0)}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Select Payment Method:'),
            SizedBox(height: 8),
            Column(
              children: paymentMethods.map((method) {
                return Card(
                  color: selectedPaymentMethod == method
                      ? Colors.blue[100]
                      : Colors.white,
                  child: ListTile(
                    title: Text(method),
                    onTap: () {
                      setState(() {
                        selectedPaymentMethod = method;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SuccessPage(),
                  ),
                );
              },
              child: Text('Proceed to Pay'),
            ),
          ],
        ),
      ),
    );
  }
}
