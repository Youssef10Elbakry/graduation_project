import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginTextfield extends StatelessWidget {
  String hintText;
  TextEditingController controller;
  LoginTextfield({super.key, required this.hintText, required this.controller});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.07,
      width: MediaQuery.of(context).size.width*0.85,
      child: TextFormField(
        obscureText: hintText == "  Password"? true: false,
        controller: controller,
        maxLines: 1,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.021,
              horizontal: MediaQuery.of(context).size.width*0.033),
          fillColor: const Color(0xffF1F4FF),
          filled: true,
          enabledBorder: OutlineInputBorder(borderSide: const BorderSide(width: 2, color: Color(0xffF1F4FF)),
              borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(borderSide: const BorderSide(width: 2, color: Color(0xffF1F4FF)),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(borderSide: const BorderSide(width: 2, color: Color(0xff1F41BB)),
              borderRadius: BorderRadius.circular(10)),
          disabledBorder: OutlineInputBorder(borderSide: const BorderSide(width: 2, color: Color(0xffF1F4FF)),
              borderRadius: BorderRadius.circular(10)),
          focusedErrorBorder: OutlineInputBorder(borderSide: const BorderSide(width: 2, color: Color(0xffF1F4FF)),
              borderRadius: BorderRadius.circular(10)),
          hintText: hintText,
          hintStyle: const TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w500,
            fontSize: 18, color: Color(0xff626262))
        ),
      ),
    );
  }
}
