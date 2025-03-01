import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project/ui/providers/home_tab_provider.dart';
import 'package:graduation_project/ui/providers/sign_in_button_provider.dart';
import 'package:graduation_project/ui/providers/user_profile_provider.dart';
import 'package:graduation_project/ui/screens/login_screen/login_screen.dart';
import 'package:graduation_project/ui/screens/main_screen/main_screen.dart';
import 'package:graduation_project/ui/screens/splash_screen.dart';
import 'package:graduation_project/ui/screens/welcome_screen/welcome_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (_)=>SignInButtonProvider()),
        ChangeNotifierProvider(create: (_)=> UserProfileProvider()),
        ChangeNotifierProvider(create: (_)=> HomeTabProvider())
      ],
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        SplashScreen.screenName: (_)=> SplashScreen(),
        WelcomeScreen.screenName: (_)=>const WelcomeScreen(),
        LoginScreen.screenName: (_)=>LoginScreen(),
        MainScreen.screenName: (_)=>const MainScreen()
      },
      initialRoute: MainScreen.screenName,
    );
  }
}

