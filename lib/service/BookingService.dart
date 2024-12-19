import 'package:http/http.dart' as http;
import 'dart:convert';
import 'auth_service.dart';

class BookingService {
  static const String baseUrl = 'http://backend-buzjet-api.test/api';

  Future<List<dynamic>> getBookings() async {
    final token = await AuthService.getToken();

    if (token == null) {
      throw Exception('No token found');
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/bookings'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      print('Bookings Response status: ${response.statusCode}');
      print('Bookings Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['data'] != null) {
          return responseData['data'];
        }
        throw Exception('Invalid bookings data format');
      }
      throw Exception('Failed to load bookings: ${response.statusCode}');
    } catch (e) {
      print('Error fetching bookings: $e');
      throw Exception('Failed to load bookings: $e');
    }
  }

  Future<void> cancelBooking(int bookingId) async {
    final token = await AuthService.getToken();

    if (token == null) {
      throw Exception('No token found');
    }

    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/bookings/$bookingId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      print('Cancel Booking Response status: ${response.statusCode}');
      print('Cancel Booking Response body: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Failed to cancel booking: ${response.statusCode}');
      }
    } catch (e) {
      print('Error canceling booking: $e');
      throw Exception('Failed to cancel booking: $e');
    }
  }
}
