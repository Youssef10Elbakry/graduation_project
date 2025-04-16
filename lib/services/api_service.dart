import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ApiService {
  static const String baseUrl = 'https://parentstarck.site/parent';

  Future<Map<String, dynamic>> processPayment({
    required String studentId,
    required double amount,
    required String token,
    required String pinCode,
  }) async {
    try {
      debugPrint('Making API call to: $baseUrl/sendMoney/$studentId');
      debugPrint('Request body: ${jsonEncode({
        'amount': amount,
        'pinCode': pinCode,
      })}');
      debugPrint('Token: $token');

      final response = await http.post(
        Uri.parse('$baseUrl/sendMoney/$studentId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'amount': amount,
          'pinCode': pinCode,
        }),
      );

      debugPrint('Response status code: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return data;
      } else {
        throw Exception(data['message'] ?? 'Something went wrong');
      }
    } catch (e) {
      debugPrint('Error in API call: $e');
      rethrow;
    }
  }
} 