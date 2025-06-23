import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/ui/screens/login_screen/login_screen.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400, // You can adjust or remove this to control width
      child: OutlinedButton.icon(
        onPressed: () {
          // Add your logout logic here
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
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        icon: const Icon(Icons.logout, color: Color(0xff001645),),
        label: const Text('Logout',style: TextStyle(color: Color(0xff001645)),),
      ),
    )
    ;
  }
}
