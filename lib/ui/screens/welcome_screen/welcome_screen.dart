import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/ui/widgets/welcome_and_login_button.dart';

class WelcomeScreen extends StatelessWidget {
  static String screenName = "Welcome Screen";
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          const Spacer(flex: 4,),
          Center(child: Image.asset("assets/images/welcome image.png")),
          const Spacer(flex: 4,),
          const Text("Empowering Parents\n With Peace Of Mind", textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, fontFamily: 'Poppins',
                fontWeight: FontWeight.w600, color: Color(0xff1F41BB)),
          ),
          const Spacer(flex: 1,),
          const Text("monitor, manage, and secure your child's\n school journey effortlessly.", textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, fontFamily: 'Poppins',
                fontWeight: FontWeight.w400, color: Color(0xff000000)),
          ),
          const Spacer(flex: 4,),
          WelcomeAndLoginButton(buttonText: "Login"),
          const Spacer(flex: 4,)
        ],
      ),
    );
  }
}
