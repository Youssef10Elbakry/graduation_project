class MidtermExam {
  final String id;
  final String name;
  final DateTime date;
  final int score;
  final int maxScore;

  MidtermExam({
    required this.id,
    required this.name,
    required this.date,
    required this.score,
    required this.maxScore,
  });

  factory MidtermExam.fromJson(Map<String, dynamic> json) {
    return MidtermExam(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      score: json['score'] ?? 0,
      maxScore: json['maxScore'] ?? 100,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'date': date.toIso8601String(),
      'score': score,
      'maxScore': maxScore,
    };
  }
}

class Quiz {
  final String id;
  final String name;
  final DateTime date;
  final int score;
  final int maxScore;

  Quiz({
    required this.id,
    required this.name,
    required this.date,
    required this.score,
    required this.maxScore,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      score: json['score'] ?? 0,
      maxScore: json['maxScore'] ?? 20,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'date': date.toIso8601String(),
      'score': score,
      'maxScore': maxScore,
    };
  }
}

class Assignment {
  final String id;
  final String name;
  final DateTime date;
  final int score;
  final int maxScore;

  Assignment({
    required this.id,
    required this.name,
    required this.date,
    required this.score,
    required this.maxScore,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      score: json['score'] ?? 0,
      maxScore: json['maxScore'] ?? 30,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'date': date.toIso8601String(),
      'score': score,
      'maxScore': maxScore,
    };
  }
}

class FinalExam {
  final DateTime date;
  final String status; // "Pending" or score/maxScore
  final int? score;
  final int? maxScore;

  FinalExam({
    required this.date,
    required this.status,
    this.score,
    this.maxScore,
  });

  factory FinalExam.fromJson(Map<String, dynamic> json) {
    return FinalExam(
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      status: json['status'] ?? 'Pending',
      score: json['score'],
      maxScore: json['maxScore'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'status': status,
      'score': score,
      'maxScore': maxScore,
    };
  }
}

class ClassParticipation {
  final String id;
  final int score;
  final int maxScore;

  ClassParticipation({
    required this.id,
    required this.score,
    required this.maxScore,
  });

  factory ClassParticipation.fromJson(Map<String, dynamic> json) {
    return ClassParticipation(
      id: json['id'] ?? '',
      score: json['score'] ?? 0,
      maxScore: json['maxScore'] ?? 10,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'score': score,
      'maxScore': maxScore,
    };
  }
}

class TeacherComment {
  final String id;
  final String teacherName;
  final String teacherImage;
  final DateTime date;
  final String comment;

  TeacherComment({
    required this.id,
    required this.teacherName,
    required this.teacherImage,
    required this.date,
    required this.comment,
  });

  factory TeacherComment.fromJson(Map<String, dynamic> json) {
    return TeacherComment(
      id: json['id'],
      teacherName: json['teacherName'],
      teacherImage: json['teacherImage'],
      date: DateTime.parse(json['date']),
      comment: json['comment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teacherName': teacherName,
      'teacherImage': teacherImage,
      'date': date.toIso8601String(),
      'comment': comment,
    };
  }
}

class GradeProgress {
  final String id;
  final DateTime date;
  final double percentage;

  GradeProgress({
    required this.id,
    required this.date,
    required this.percentage,
  });

  factory GradeProgress.fromJson(Map<String, dynamic> json) {
    return GradeProgress(
      id: json['_id'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      percentage: (json['percentage'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'date': date.toIso8601String(),
      'percentage': percentage,
    };
  }
}

class Student {
  final String id;
  final String name;
  final int grade;
  final String section;
  final String profilePicture;

  Student({
    required this.id,
    required this.name,
    required this.grade,
    required this.section,
    required this.profilePicture,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      grade: json['grade'] ?? 0,
      section: json['section'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'grade': grade,
      'section': section,
      'profilePicture': profilePicture,
    };
  }
}

class SubjectGrades {
  final String id;
  final String subject;
  final int semester;
  final String academicYear;
  final String teacher;
  final String letterGrade;
  final double overallPercentage;
  final List<MidtermExam> midterms;
  final List<Quiz> quizzes;
  final List<Assignment> assignments;
  final ClassParticipation classParticipation;
  final FinalExam finalExam;
  final List<GradeProgress> gradeProgress;

  SubjectGrades({
    required this.id,
    required this.subject,
    required this.semester,
    required this.academicYear,
    required this.teacher,
    required this.letterGrade,
    required this.overallPercentage,
    required this.midterms,
    required this.quizzes,
    required this.assignments,
    required this.classParticipation,
    required this.finalExam,
    required this.gradeProgress,
  });

  factory SubjectGrades.fromJson(Map<String, dynamic> json) {
    return SubjectGrades(
      id: json['_id'] ?? '',
      subject: json['subject'] ?? '',
      semester: json['semester'] ?? 1,
      academicYear: json['academicYear'] ?? '',
      teacher: json['teacher'] ?? '',
      letterGrade: json['letterGrade'] ?? '',
      overallPercentage: (json['overallPercentage'] ?? 0.0).toDouble(),
      midterms: (json['midterms'] as List? ?? [])
          .map((item) => MidtermExam.fromJson(item))
          .toList(),
      quizzes: (json['quizzes'] as List? ?? [])
          .map((item) => Quiz.fromJson(item))
          .toList(),
      assignments: (json['assignments'] as List? ?? [])
          .map((item) => Assignment.fromJson(item))
          .toList(),
      classParticipation: ClassParticipation.fromJson(json['classParticipation'] ?? {}),
      finalExam: FinalExam.fromJson(json['finalExam'] ?? {}),
      gradeProgress: (json['gradeProgress'] as List? ?? [])
          .map((item) => GradeProgress.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'subject': subject,
      'semester': semester,
      'academicYear': academicYear,
      'teacher': teacher,
      'letterGrade': letterGrade,
      'overallPercentage': overallPercentage,
      'midterms': midterms.map((item) => item.toJson()).toList(),
      'quizzes': quizzes.map((item) => item.toJson()).toList(),
      'assignments': assignments.map((item) => item.toJson()).toList(),
      'classParticipation': classParticipation.toJson(),
      'finalExam': finalExam.toJson(),
      'gradeProgress': gradeProgress.map((item) => item.toJson()).toList(),
    };
  }
}

class ApiResponse {
  final String message;
  final Student student;
  final Map<String, List<SubjectGrades>> gradesBySubject;

  ApiResponse({
    required this.message,
    required this.student,
    required this.gradesBySubject,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    Map<String, List<SubjectGrades>> grades = {};
    
    if (json['gradesBySubject'] != null) {
      (json['gradesBySubject'] as Map<String, dynamic>).forEach((key, value) {
        grades[key] = (value as List)
            .map((item) => SubjectGrades.fromJson(item))
            .toList();
      });
    }

    return ApiResponse(
      message: json['message'] ?? '',
      student: Student.fromJson(json['student'] ?? {}),
      gradesBySubject: grades,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> grades = {};
    gradesBySubject.forEach((key, value) {
      grades[key] = value.map((item) => item.toJson()).toList();
    });

    return {
      'message': message,
      'student': student.toJson(),
      'gradesBySubject': grades,
    };
  }
} 