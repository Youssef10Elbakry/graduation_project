import 'package:flutter/cupertino.dart';
import 'package:graduation_project/ui/widgets/grades_button.dart';
import 'package:graduation_project/ui/screens/student_profile_screen/grades_tab_bar_container.dart';

class GradesTabBarView extends StatelessWidget {
  String id;
  GradesTabBarView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    print(MediaQuery.of(context).size.height);
    print(MediaQuery.of(context).size.width);
    return Column(
      children: [
        GradeTabBarContainer(examName: "Midterm Exam 2", examGrade: "98/100", subjectName: "Science"),
        SizedBox(height: height*0.022,),
        GradeTabBarContainer(examName: "Quiz 1", examGrade: "18/20", subjectName: "Science"),
        SizedBox(height: height*0.022,),
        GradesButton(id: id)

      ],
    );
  }
}
