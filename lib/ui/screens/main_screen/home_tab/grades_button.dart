import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradesButton extends StatefulWidget {
  String id;
   GradesButton({super.key, required this.id});

  @override
  State<GradesButton> createState() => _GradesButtonState();
}

class _GradesButtonState extends State<GradesButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xff1F53B9),
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(8)
        ),
        width: 376,
        height: 60,
        child: const Row(
          children: [
            Spacer(),
            Text("Grades", style: TextStyle(fontSize: 20, color: Colors.white),),
            Spacer(),
            Icon(Icons.chevron_right, color: Colors.white,),
            SizedBox(width: 10,)
          ],
        ),
      ),
    );
  }
}
