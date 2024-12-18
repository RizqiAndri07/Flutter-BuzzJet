import 'package:flutter/material.dart';
import '../../service/BookingService.dart';

class MyTripPage extends StatefulWidget {
  @override
  _MyTripPageState createState() => _MyTripPageState();
}

class _MyTripPageState extends State<MyTripPage> {
  final BookingService _bookingService = BookingService();
  List<dynamic>? _bookings;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  Future<void> _loadBookings() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final data = await _bookingService.getBookings();

      setState(() {
        _bookings = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _cancelBooking(int bookingId) async {
    try {
      await _bookingService.cancelBooking(bookingId);
      _showMessage('Booking canceled successfully');
      _loadBookings();
    } catch (e) {
      _showMessage('Failed to cancel booking: $e');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showCancelConfirmationDialog(int bookingId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cancel Booking'),
          content: Text('Are you sure you want to cancel this booking?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _cancelBooking(bookingId);
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: $_error'),
            ElevatedButton(
              onPressed: _loadBookings,
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_bookings == null || _bookings!.isEmpty) {
      return Center(child: Text('No bookings available'));
    }

    return ListView.builder(
      itemCount: _bookings!.length,
      itemBuilder: (context, index) {
        final booking = _bookings![index];
        return Card(
          margin: EdgeInsets.all(8.0),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking['package']['name'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('Seats: ${booking['seats']}'),
                Text('Total: ${booking['total_price']}'),
                Text('Status: ${booking['status']}'),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () =>
                          _showCancelConfirmationDialog(booking['id']),
                      child: Text('Cancel'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
