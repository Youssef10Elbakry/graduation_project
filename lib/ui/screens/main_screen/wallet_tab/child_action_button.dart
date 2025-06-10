import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChildActionButton extends StatefulWidget {
  String text;
  ChildActionButton({super.key, required this.text});

  @override
  State<ChildActionButton> createState() => _ChildActionButtonState();
}

class _ChildActionButtonState extends State<ChildActionButton> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
        height: height*0.0336,
        width: width*0.370625,
        child: ElevatedButton(onPressed: (){},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffE8E8E8), // Change background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Set border radius
                side: const BorderSide(color: Color(0xffE8E8E8), width: 1), // Set border
              ),
            ),

            child: Row(
              children: [
                Text(widget.text,
                  style: const TextStyle(fontSize: 12, color: Color(0xffA8AAAF)),),
                const Spacer(),
                Icon(Icons.arrow_forward_ios, color: const Color(0xffA8AAAF),size: width*0.03571,)
              ],
            )));
  }
}
