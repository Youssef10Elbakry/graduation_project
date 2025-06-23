import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradeTabBarContainer extends StatefulWidget {
  String examName;
  String examGrade;
  String subjectName;
  GradeTabBarContainer({super.key, required this.examName, required this.examGrade, required this.subjectName});

  @override
  State<GradeTabBarContainer> createState() => _GradeTabBarContainerState();
}

class _GradeTabBarContainerState extends State<GradeTabBarContainer> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width*0.925,
      height: height*0.142,
      padding: EdgeInsets.symmetric(horizontal: width*0.07299, vertical: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width*0.0292),
        border: Border.all(color: Color(0xffD2D5DA))
      ),
      child: Row(
        children: [
          Text(widget.examName, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: Color.fromRGBO(0, 0, 0, 0.75)),),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text(widget.examGrade, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 34, color: Color.fromRGBO(0, 0, 0, 0.75)),),
            Text(widget.subjectName, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Color.fromRGBO(0, 0, 0, 0.50)),),
          ],)
        ],
      ),
    );
  }
}
