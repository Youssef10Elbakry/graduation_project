import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/ui/screens/login_screen/login_screen.dart';

class WelcomeAndLoginButton extends StatelessWidget {
  String buttonText;
  WelcomeAndLoginButton({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    print("Screen Height: ${MediaQuery.of(context).size.height}"); //973.33
    print("Screen Width: ${MediaQuery.of(context).size.width}"); //448.0
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.065,
      width: MediaQuery.of(context).size.width*0.85,
      child: ElevatedButton(onPressed: (){
        if(buttonText == "Login"){
          Navigator.pushNamed(context, LoginScreen.screenName);
        }
        },
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff1F41BB),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        child: Text(buttonText,
            style: const TextStyle(fontSize:22, fontFamily: "Poppins",    // make the font size responsive
                color: Color(0xffFFFFFF), fontWeight: FontWeight.w600),),
      ),
    );
  }
}
