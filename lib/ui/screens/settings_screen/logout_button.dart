import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_project/ui/screens/login_screen/login_screen.dart';

class LogoutButton extends StatelessWidget {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width*0.9732, // You can adjust or remove this to control width
      child: OutlinedButton.icon(
        onPressed: () async {
          await storage.delete(key: "authentication_key");
          Navigator.pushNamedAndRemoveUntil(
            context,
            LoginScreen.screenName,
                (route) => false,
          );
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(width: 1.2, color: Color(0xff001645)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          foregroundColor: const Color(0xff001645), // Text and icon color
          padding:  EdgeInsets.symmetric(vertical: height*0.0175),
        ),
        icon: const Icon(Icons.logout, color: Color(0xff001645),),
        label: const Text('Logout',style: TextStyle(color: Color(0xff001645)),),
      ),
    )
    ;
  }
}
