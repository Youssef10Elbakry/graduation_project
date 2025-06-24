import 'package:flutter/material.dart';
import 'package:graduation_project/ui/screens/grades_screen/grades_screen.dart';

class GradesButton extends StatelessWidget {
  final String id;

  const GradesButton({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          GradesScreen.routeName,
          arguments: id,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff1F53B9),
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        width: width * 0.9148,
        height: height * 0.0656,
        child: Row(
          children: [
            const Spacer(),
            const Text(
              "Grades",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            const Spacer(),
            const Icon(Icons.chevron_right, color: Colors.white),
            SizedBox(width: width * 0.024),
          ],
        ),
      ),
    );
  }
}
