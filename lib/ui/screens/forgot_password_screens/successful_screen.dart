import 'package:flutter/material.dart';
import 'package:graduation_project/ui/widgets/custom_button.dart';
import 'package:graduation_project/ui/widgets/custom_icon_button.dart';
import 'package:graduation_project/ui/widgets/custom_text.dart';
import 'package:graduation_project/ui/screens/login_screen/login_screen.dart';
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
            const Icon(Icons.check_circle, color: Color(0xFF1F41BB), size: 150),
            const SizedBox(height: 20),
            const Text("Successful", style: TextStyle(fontSize: 20, color: Colors.black)),
            const SizedBox(height: 20),
            const CustomText(
              text: "Congratulations! Your password has been changed. Press continue to log in.",
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Continue",
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) =>  LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
