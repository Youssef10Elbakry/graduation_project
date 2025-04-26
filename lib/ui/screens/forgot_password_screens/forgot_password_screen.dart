import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_icon_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_text_field.dart';
import 'verification_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {

  static const String routeName = '/forgot_password_screen';
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  String? _emailText;

  void _handleResetPassword() {
    final input = _emailController.text.trim();

    if (input == "y.mahmoud@gmail.com") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const VerificationScreen()),
      );
    } else {
      setState(() {
        _emailText = "Incorrect Email Address";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomIconButton(),
        title: const Text(
          'Forgot Password',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: "Please enter your email to reset the password",
            ),
            const SizedBox(height: 20),
            const Text(
              "Your Email",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              hintText: "username@gmail.com",
              controller: _emailController,
              onChanged: (_) {
                if (_emailText != null) {
                  setState(() {
                    _emailText = null;
                  });
                }
              },
            ),
            if (_emailText != null && _emailText!.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                _emailText!,
                style: const TextStyle(color: Colors.red, fontSize: 20),
              ),
              const SizedBox(height: 10),
            ],
            CustomButton(
              text: "Reset Password",
              onTap: _handleResetPassword,
            ),
          ],
        ),
      ),
    );
  }
}
