import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_icon_button.dart';
import '../widgets/custom_text.dart';
class SuccessfulScreen extends StatelessWidget {
  static const String routeName = '/successful_screen';
  const SuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomIconButton(),
    ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.check_circle,color: Color(0xFF1F41BB),size: 150,),
              SizedBox(height: 20,),
              Text("Successful" , style: TextStyle(fontSize: 20,color: Colors.black),),
              SizedBox(height: 20),
              CustomText(text: "Congratulations! Your password has "
                  "been changed press continue to log in"),
              SizedBox(height: 20),
              CustomButton(text: "Continue", onTap:() {})
            ],
          ),
        ),
      );

  }
}
