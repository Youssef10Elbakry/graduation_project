import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/grades_provider.dart';
import '../../widgets/grade_item_widget.dart';
import '../../widgets/grade_timeline_widget.dart';


class GradesDetailsScreen extends StatefulWidget {
  static const String routeName = '/GradesDetails';
  final String studentId;
  final String subjectName;
  
  const GradesDetailsScreen({
    super.key,
    required this.studentId,
    required this.subjectName,
  });

  @override
  State<GradesDetailsScreen> createState() => _GradesDetailsScreenState();
}

class _GradesDetailsScreenState extends State<GradesDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GradesProvider>().loadSubjectGrades(widget.studentId, widget.subjectName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.subjectName,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<GradesProvider>(
        builder: (context, gradesProvider, child) {
          if (gradesProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (gradesProvider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${gradesProvider.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => gradesProvider.loadSubjectGrades(widget.studentId, widget.subjectName),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final grades = gradesProvider.currentSubjectGrades;
          if (grades == null) {
            return const Center(
              child: Text('No grades available'),
            );
          }

          return RefreshIndicator(
            onRefresh: () => gradesProvider.loadSubjectGrades(widget.studentId, widget.subjectName),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Overall Grade Section - Moved to top
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Overall Grade',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Teacher: ${grades.teacher}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${grades.overallPercentage.toStringAsFixed(1)}%',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            Text(
                              'Grade ${grades.letterGrade}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Midterm Exams Section
                  _buildSectionTitle('Midterm Exams'),
                  const SizedBox(height: 12),
                  ...grades.midterms.map((exam) => GradeItemWidget(
                    name: exam.name,
                    date: exam.date,
                    score: exam.score,
                    maxScore: exam.maxScore,
                  )),
                  
                  const SizedBox(height: 24),
                  
                  // Quizzes Section
                  _buildSectionTitle('Quizzes'),
                  const SizedBox(height: 12),
                  ...grades.quizzes.map((quiz) => GradeItemWidget(
                    name: quiz.name,
                    date: quiz.date,
                    score: quiz.score,
                    maxScore: quiz.maxScore,
                  )),
                  
                  const SizedBox(height: 24),
                  
                  // Assignments Section
                  _buildSectionTitle('Assignments'),
                  const SizedBox(height: 12),
                  ...grades.assignments.map((assignment) => GradeItemWidget(
                    name: assignment.name,
                    date: assignment.date,
                    score: assignment.score,
                    maxScore: assignment.maxScore,
                  )),
                  
                  const SizedBox(height: 24),
                  
                  // Class Participation Section
                  _buildSectionTitle('Class Participation'),
                  const SizedBox(height: 12),
                  ParticipationScoreWidget(
                    score: grades.classParticipation.score,
                    maxScore: grades.classParticipation.maxScore,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Final Exam Section
                  _buildSectionTitle('Final Exam'),
                  const SizedBox(height: 12),
                  PendingGradeItemWidget(
                    title: 'Final Exam',
                    date: grades.finalExam.date,
                    status: grades.finalExam.status,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Grade Timeline Section
                  GradeTimelineWidget(
                    gradeProgress: grades.gradeProgress,
                  ),
                  

                  
                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
} 