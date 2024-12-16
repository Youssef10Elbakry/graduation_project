import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/ui/screens/login_screen/login_textfield.dart';
import 'package:graduation_project/ui/widgets/welcome_and_login_button.dart';

class LoginScreen extends StatelessWidget {
  static String screenName = "Login Screen";
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(flex: 10,),
          const Center(
            child: Text("Login here",textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold, color: Color(0xff1F41BB)),),
          ),
          const Spacer(flex: 3,),
          const Text("Welcome back you’ve\n been missed!", textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontFamily: 'Poppins',
                fontWeight: FontWeight.w600, color: Color(0xff000000)),),
          const Spacer(flex: 8,),
          LoginTextfield(hintText: "  Email"),
          const Spacer(flex: 3,),
          LoginTextfield(hintText: "  Password"),
          Spacer(flex: 2,),
          Row(
            children: [
              const Spacer(flex: 9,),
              TextButton(onPressed: (){},
                  child: const Text("Forgot your password?", style: TextStyle(fontFamily: "Poppins", fontSize: 16,
                  fontWeight: FontWeight.w600, color: Color(0xff1F41BB)),
                  )),
              const Spacer(flex: 1,)
            ],
          ),
          Spacer(flex:  2,),
          WelcomeAndLoginButton(buttonText: "Sign in",),
          Spacer(flex: 30,)
        ],
      ),
    );
  }

}
