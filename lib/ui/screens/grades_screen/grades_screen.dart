import 'package:flutter/material.dart';

class GradesScreen extends StatefulWidget {
  static const String routeName = '/student-grades';

  const GradesScreen({super.key});

  @override
  _GradesScreenState createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen> {
  Future<Map<String, dynamic>> fetchStudentData() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate API delay

    return {
      "name": "Ethan Carter",
      "grade": "10th Grade",
      "gpa": 3.8,
      "subjects": {
        "Mathematics": 92,
        "Science": 88,
        "English": 75,
        "History": 85,
        "Physical Education": 95,
        "Art": 70,
      }
    };
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
        future: fetchStudentData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.hasError) {
            return const Center(child: Text('Failed to load data'));
          }

          final student = snapshot.data!;
          final subjects = student["subjects"] as Map<String, int>;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Student Info
                Row(
                  children: [
                    Expanded(
                      child: Column(
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
                          const SizedBox(height: 2),
                          Text(
                            "${student["grade"]} | GPA: ${student["gpa"]}",
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                    // Student Image
                    Container(
                      height: 80,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/glasses_student.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Subjects Header
                const Text("Subjects",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),

                // Grid of subjects
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

                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                if (subject == "Mathematics") ...[
                                  const Icon(Icons.calculate,
                                      size: 18, color: Colors.black),
                                  const SizedBox(width: 6),
                                ],
                                Flexible(
                                  child: Text(
                                    subject,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              grade.toString(),
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF615C8A)), // Custom purple
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                ),
                Center(
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/grades_picture.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
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
