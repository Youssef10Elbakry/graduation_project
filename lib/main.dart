import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduation_project/ui/providers/student_profile_provider.dart';
import 'package:provider/provider.dart';

import 'package:graduation_project/ui/providers/home_tab_provider.dart';
import 'package:graduation_project/ui/providers/sign_in_button_provider.dart';
import 'package:graduation_project/ui/providers/student_profile_tab_bar_provider.dart';
import 'package:graduation_project/ui/providers/user_profile_provider.dart';
import 'package:graduation_project/ui/providers/wallet_tab_provider.dart';
import 'package:graduation_project/ui/providers/passcode_provider.dart';
import 'package:graduation_project/ui/providers/comfirmation_provider.dart';
import 'package:graduation_project/ui/screens/attendence_screen/attendance_screen.dart';
import 'package:graduation_project/ui/screens/splash_screen.dart';
import 'package:graduation_project/ui/screens/welcome_screen/welcome_screen.dart';
import 'package:graduation_project/ui/screens/login_screen/login_screen.dart';
import 'package:graduation_project/ui/screens/main_screen/main_screen.dart';
import 'package:graduation_project/ui/screens/settings_screen/settings_screen.dart';
import 'package:graduation_project/ui/screens/student_profile_screen/student_profile_screen.dart';
import 'package:graduation_project/ui/screens/passcode_screen/ConfirmationScreen.dart';
import 'package:graduation_project/ui/screens/passcode_screen/error_screen.dart';
import 'package:graduation_project/ui/screens/passcode_screen/passcode_screen.dart';
import 'package:graduation_project/ui/screens/passcode_screen/success_screen.dart';
import 'package:graduation_project/ui/screens/forgot_password_screens/forgot_password_screen.dart';
import 'package:graduation_project/ui/screens/forgot_password_screens/successful_screen.dart';
import 'package:graduation_project/ui/screens/transactions_details/transactions_details.dart';
import 'package:graduation_project/ui/screens/grades_screen/grades_screen.dart';
import 'package:graduation_project/ui/screens/main_screen/profile_tab/profile_tab.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignInButtonProvider()),
        ChangeNotifierProvider(create: (_) => UserProfileProvider()),
        ChangeNotifierProvider(create: (_) => HomeTabProvider()),
        ChangeNotifierProvider(create: (_) => WalletTabProvider()),
        ChangeNotifierProvider(create: (_) => StudentProfileTabBarProvider()),
        ChangeNotifierProvider(create: (_) => PasscodeProvider()),
        ChangeNotifierProvider(create: (_) => ConfirmationProvider()),
        ChangeNotifierProvider(create: (_)=> StudentProfileProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        SplashScreen.screenName: (_) => SplashScreen(),
        WelcomeScreen.screenName: (_) => const WelcomeScreen(),
        LoginScreen.screenName: (_) => LoginScreen(),
        MainScreen.screenName: (_) => const MainScreen(),
        SettingsScreen.screenName: (_) => const SettingsScreen(),
        StudentProfileScreen.screenName: (_) => StudentProfileScreen(),
        AttendanceScreen.screenName: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return AttendanceScreen(studentId: args['studentId']);
        },
        PaymentSuccessfulScreen.routeName: (_) => const PaymentSuccessfulScreen(),
        ErrorScreen.routeName: (_) => const ErrorScreen(),
        ConfirmationScreen.routeName: (_) => const ConfirmationScreen(),
        PasscodeScreen.routeName: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return PasscodeScreen(
            studentId: args['studentId'],
            amount: args['amount'],
          );
        },
        ForgotPasswordScreen.routeName: (_) => const ForgotPasswordScreen(),
        SuccessfulScreen.routeName: (_) => const SuccessfulScreen(),
        TransactionsDetailsScreen.routeName: (_) => const TransactionsDetailsScreen(),
        GradesScreen.routeName: (_) => const GradesScreen(),
        ProfileTab.screenName: (_) => ProfileTab(),
      },
      initialRoute: MainScreen.screenName,
    );
  }
}
