import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudentProfileTextfield extends StatelessWidget {
  String labelText;
  String? infoText;

  TextEditingController controller = TextEditingController();
  OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8), // Rounded corners
    borderSide: BorderSide(color: Color(0xff9E9E9E)), // No border
  );
  StudentProfileTextfield({super.key, required this.labelText, required this.infoText});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    TextEditingController controller = TextEditingController(text: infoText);
    return SizedBox(
      width: labelText == "Age"?width*0.34:width*0.5353,
      height: height*0.06,
      child: TextField(
        controller: controller,
        readOnly: true,
        style: TextStyle(color:labelText == "Full Name"? const Color(0xff212121):const Color(0xff757575)),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Color(0xff757575)),
          filled: true,
          fillColor: const Color(0xFFF5F9FF), // Light blueish background
          border: border,
          focusedBorder: border,
          enabledBorder: border,
          errorBorder: border,

        ),
      ),
    );
  }
}
