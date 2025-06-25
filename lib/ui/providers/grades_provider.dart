import 'package:flutter/foundation.dart';
import '../../models/grade_models.dart';
import '../../services/grades_service.dart';

class GradesProvider with ChangeNotifier {
  final GradesService _gradesService = GradesService();
  
  SubjectGrades? _currentSubjectGrades;
  List<String> _subjects = [];
  String? _selectedSubject;
  bool _isLoading = false;
  String? _error;
  Student? _student;
  String? _currentStudentId;
  final Map<String, List<SubjectGrades>> _allGradesBySubject = {};

  // Getters
  SubjectGrades? get currentSubjectGrades => _currentSubjectGrades;
  List<String> get subjects => _subjects;
  String? get selectedSubject => _selectedSubject;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Student? get student => _student;
  Map<String, List<SubjectGrades>> get allGradesBySubject => _allGradesBySubject;

  // Load subjects
  Future<void> loadSubjects(String studentId) async {
    _setLoading(true);
    _clearError();
    
    try {
      _currentStudentId = studentId; // Store the student ID
      final apiResponse = await _gradesService.getStudentGrades(studentId);
      _student = apiResponse.student;
      _allGradesBySubject.clear();
      _allGradesBySubject.addAll(apiResponse.gradesBySubject);
      _subjects = apiResponse.gradesBySubject.keys.toList();
      
      if (_subjects.isNotEmpty && _selectedSubject == null) {
        _selectedSubject = _subjects.first;
        await loadSubjectGrades(studentId, _selectedSubject!);
      }
    } catch (e) {
      _setError('Failed to load subjects: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Load grades for a specific subject
  Future<void> loadSubjectGrades(String studentId, String subjectName) async {
    _setLoading(true);
    _clearError();
    
    try {
      _currentStudentId = studentId;
      // First load all subjects if not already loaded
      if (_allGradesBySubject.isEmpty) {
        final apiResponse = await _gradesService.getStudentGrades(studentId);
        _student = apiResponse.student;
        _allGradesBySubject.clear();
        _allGradesBySubject.addAll(apiResponse.gradesBySubject);
        _subjects = apiResponse.gradesBySubject.keys.toList();
      }
      
      // Then get the specific subject grades
      final subjectGrades = _allGradesBySubject[subjectName];
      _currentSubjectGrades = subjectGrades?.isNotEmpty == true ? subjectGrades!.first : null;
      _selectedSubject = subjectName;
    } catch (e) {
      _setError('Failed to load grades: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Refresh current subject grades
  Future<void> refreshGrades() async {
    if (_currentStudentId != null) {
      await loadSubjects(_currentStudentId!);
    }
  }

  // Select a different subject
  Future<void> selectSubject(String subjectName) async {
    if (_selectedSubject != subjectName && _currentStudentId != null) {
      await loadSubjectGrades(_currentStudentId!, subjectName);
    }
  }

  // Add teacher comment (for admin) - functionality removed as API doesn't support it
  Future<bool> addTeacherComment(String comment) async {
    _setLoading(true);
    _clearError();
    
    try {
      // This functionality would need to be implemented in the API
      // For now, just simulate success
      await Future.delayed(const Duration(milliseconds: 500));
      return true;
    } catch (e) {
      _setError('Failed to add comment: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Calculate overall grade percentage
  double calculateOverallPercentage() {
    if (_currentSubjectGrades == null) return 0.0;
    
    double totalPoints = 0;
    double maxPoints = 0;
    
    // Midterm exams
    for (var exam in _currentSubjectGrades!.midterms) {
      totalPoints += exam.score;
      maxPoints += exam.maxScore;
    }
    
    // Quizzes
    for (var quiz in _currentSubjectGrades!.quizzes) {
      totalPoints += quiz.score;
      maxPoints += quiz.maxScore;
    }
    
    // Assignments
    for (var assignment in _currentSubjectGrades!.assignments) {
      totalPoints += assignment.score;
      maxPoints += assignment.maxScore;
    }
    
    // Class participation
    totalPoints += _currentSubjectGrades!.classParticipation.score;
    maxPoints += _currentSubjectGrades!.classParticipation.maxScore;
    
    return maxPoints > 0 ? (totalPoints / maxPoints) * 100 : 0.0;
  }

  // Get grade letter based on percentage
  String getGradeLetter(double percentage) {
    if (percentage >= 90) return 'A';
    if (percentage >= 80) return 'B';
    if (percentage >= 70) return 'C';
    if (percentage >= 60) return 'D';
    return 'F';
  }

  // Private helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
  }

  // Clear all data
  void clear() {
    _currentSubjectGrades = null;
    _subjects = [];
    _selectedSubject = null;
    _currentStudentId = null;
    _isLoading = false;
    _error = null;
    notifyListeners();
  }
} 