import 'package:flutter/material.dart';
import 'package:graduation_project/ui/screens/login_screen/login_screen.dart';
import 'package:graduation_project/ui/screens/welcome_screen/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        WelcomeScreen.screenName: (_)=>const WelcomeScreen(),
        LoginScreen.screenName: (_)=>const LoginScreen(),
      },
      initialRoute: WelcomeScreen.screenName,
    );
  }
}

