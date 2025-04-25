import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import '../models/attendance_record.dart';

class AttendanceService {
  static final _logger = Logger('AttendanceService');
  static const String baseUrl = 'https://parentstarck.site/parent';
  // You should store this securely in environment variables or secure storage
  static const String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXJlbnRJZCI6IjY3YzFlMjAxYTczMTc5MDk3YTE4Yjk2ZCIsImlhdCI6MTc0MjYwMTM5Mn0.SSztEZH_k1-53I0YXqHm5S87IguOpL6pkcvx__mnRuw';

  Future<List<AttendanceRecord>> getStudentAttendance(String studentId) async {
    try {
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