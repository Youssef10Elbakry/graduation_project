import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/grade_models.dart';

class GradesService {
  static const String baseUrl = 'https://parentstarck.site'; 
  
  static const String TOKEN_KEY = 'authentication_key';
  final secureStorage = const FlutterSecureStorage();
  
  // Get token from secure storage
  Future<String?> _getToken() async {
    return await secureStorage.read(key: TOKEN_KEY);
  }
  
  // Singleton pattern
  static final GradesService _instance = GradesService._internal();
  factory GradesService() => _instance;
  GradesService._internal();

  // HTTP client with common headers
  Future<Map<String, String>> _getHeaders() async {
    final token = await _getToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // Get all student grades with dynamic student ID
  Future<ApiResponse> getStudentGrades(String studentId) async {
    try {
      final token = await _getToken();
      print('📡 Making API request to: $baseUrl/parent/student-grades/$studentId');
      print('🔑 Using token: ${token?.substring(0, 20)}...');
      
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/parent/student-grades/$studentId'),
        headers: headers,
      );

      print('📊 Response status: ${response.statusCode}');
      print('📝 Response body length: ${response.body.length}');
      print('📄 Full API Response:');
      print('=' * 50);
      print(response.body.toString());
      print('=' * 50);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        // print('✅ JSON parsed successfully');
        // print('🔍 Parsed JSON structure:');
        // print(const JsonEncoder.withIndent('  ').convert(jsonData));
        // print('=' * 50);
        return ApiResponse.fromJson(jsonData);
      } else {
        print('❌ API Error - Status: ${response.statusCode}');
        print('❌ Response: ${response.body}');
        throw ApiException('Failed to load grades: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('🚨 Exception occurred: $e');
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException('Network error: $e');
    }
  }

  // Get grades for a specific subject
  Future<SubjectGrades?> getSubjectGrades(String studentId, String subjectName) async {
    try {
      print('🎯 Fetching grades for student: $studentId, subject: $subjectName');
      final apiResponse = await getStudentGrades(studentId);
      final subjectGrades = apiResponse.gradesBySubject[subjectName];
      
      if (subjectGrades == null || subjectGrades.isEmpty) {
        print('⚠️ No grades found for subject: $subjectName');
        print('📚 Available subjects: ${apiResponse.gradesBySubject.keys.join(', ')}');
        return null;
      }
      
      print('✅ Found grades for $subjectName');
      return subjectGrades.first;
    } catch (e) {
      throw ApiException('Failed to get subject grades: $e');
    }
  }

  // Get all subjects for a student
  Future<List<String>> getSubjects(String studentId) async {
    try {
      final apiResponse = await getStudentGrades(studentId);
      return apiResponse.gradesBySubject.keys.toList();
    } catch (e) {
      throw ApiException('Network error: $e');
    }
  }

  // Mock data for development/testing - using real API structure
  Future<SubjectGrades> getMockSubjectGrades(String studentId) async {
    // This method is no longer needed as we're using real API
    // But keeping for backwards compatibility
    final apiResponse = await getStudentGrades(studentId);
    final mathGrades = apiResponse.gradesBySubject['Mathematics'];
    return mathGrades?.first ?? _createEmptySubjectGrades();
  }

  SubjectGrades _createEmptySubjectGrades() {
    return SubjectGrades(
      id: '',
      subject: 'Mathematics',
      semester: 1,
      academicYear: '2024-2025',
      teacher: 'Unknown',
      letterGrade: 'N/A',
      overallPercentage: 0.0,
      midterms: [],
      quizzes: [],
      assignments: [],
      classParticipation: ClassParticipation(id: '', score: 0, maxScore: 10),
      finalExam: FinalExam(date: DateTime.now(), status: 'Pending'),
      gradeProgress: [],
    );
  }
}

class ApiException implements Exception {
  final String message;
  
  ApiException(this.message);
  
  @override
  String toString() => 'ApiException: $message';
} 