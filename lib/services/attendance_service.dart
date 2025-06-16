import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/attendance_record.dart';

class AttendanceService {
  static final _logger = Logger('AttendanceService');
  static const String baseUrl = 'https://parentstarck.site/parent';
  static const String TOKEN_KEY = 'authentication_key';
  final secureStorage = const FlutterSecureStorage();
  
  // Get token from secure storage
  Future<String?> _getToken() async {
    return await secureStorage.read(key: TOKEN_KEY);
  }

  Future<List<AttendanceRecord>> getStudentAttendance(String studentId) async {
    try {
      final String? token = await _getToken();
      if (token == null) {
        throw Exception('Authentication token not found');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/get-student-all-data/$studentId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      _logger.info('Response status: ${response.statusCode}');
      _logger.fine('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData.containsKey('student') && 
            responseData['student'].containsKey('attendances')) {
          final List<dynamic> attendances = responseData['student']['attendances'];
          return attendances.map((json) => AttendanceRecord.fromJson(json)).toList();
        } else {
          throw Exception('No attendance data found in response');
        }
      } else {
        throw Exception('Failed to load attendance data: ${response.statusCode}');
      }
    } catch (e) {
      _logger.severe('Error fetching attendance data', e);
      rethrow;
    }
  }
} 