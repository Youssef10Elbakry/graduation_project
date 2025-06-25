import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_project/ui/screens/grades_details/grades_details_screen.dart';
import 'package:http/http.dart' as http;

class GradesScreen extends StatefulWidget {
  static const String routeName = '/student-grades';

  const GradesScreen({super.key});

  @override
  _GradesScreenState createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen> {
  late Future<Map<String, dynamic>> studentFuture;
  late String studentId;

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    studentId = ModalRoute.of(context)!.settings.arguments as String;
    studentFuture = fetchStudentData(studentId);
  }

  Future<Map<String, dynamic>> fetchStudentData(String id) async {
    print("Fetching student data for ID: $id");

    final token = await secureStorage.read(key: "authentication_key");
    if (token == null) {
      throw Exception("No token found in secure storage");
    }

    final url = Uri.parse('https://parentstarck.site/parent/student-grades/$id');
    print("Calling API: $url");

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final student = data['student'];
      final gradesMap = data['gradesBySubject'] as Map<String, dynamic>;

      Map<String, double> subjectsWithPercentages = {};
      gradesMap.forEach((subject, gradesList) {
        if (gradesList != null && gradesList.isNotEmpty) {
          subjectsWithPercentages[subject] =
              gradesList[0]['overallPercentage'].toDouble();
        }
      });

      return {
        "name": student['name'],
        "grade": "${student['grade']}th Grade",
        "subjects": subjectsWithPercentages,
      };
    } else {
      throw Exception('Failed to load student grades');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Grades"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: const BackButton(),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: studentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.hasError) {
            return const Center(child: Text('Failed to load data'));
          }

          final student = snapshot.data!;
          final subjects = student["subjects"] as Map<String, double>;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Student Info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Student Info",
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 4),
                    Text(student["name"],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    Text(student["grade"],
                        style: TextStyle(
                            color: Colors.grey.shade700, fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 24),
                const Text("Subjects",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),

                // Subject Grid
                Expanded(
                  child: GridView.builder(
                    itemCount: subjects.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2.2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      final subject = subjects.keys.elementAt(index);
                      final grade = subjects[subject]!;

                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            GradesDetailsScreen.routeName,
                            arguments: {
                              'studentId': studentId,
                              'subjectName': subject,
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                subject,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const Spacer(),
                              Text(
                                "${grade.toStringAsFixed(1)}%",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF615C8A),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
