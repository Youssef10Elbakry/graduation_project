import 'package:flutter/cupertino.dart';
import 'package:graduation_project/ui/screens/main_screen/home_tab/grades_button.dart';
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
        GradeTabBarContainer(examName: "Midterm", examGrade: "20/30", subjectName: "English"),
        SizedBox(height: height*0.022,),
        GradeTabBarContainer(examName: "Midterm", examGrade: "20/30", subjectName: "English"),
        SizedBox(height: height*0.022,),
        GradesButton(id: id)

      ],
    );
  }
}
