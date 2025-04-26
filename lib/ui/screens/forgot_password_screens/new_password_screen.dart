import 'package:flutter/material.dart';
import 'package:forgot_password_screen/ui/screens/successful_screen.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_icon_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_text_field.dart';

class SetNewPasswordScreen extends StatefulWidget {
  static const String routeName = '/new_password_screen';
  const SetNewPasswordScreen({super.key});

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String? _errorText;

  // Function to handle the password validation and navigation
  void _handleUpdatePassword() {
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    // Check if either field is empty
    if (password.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        _errorText = "Please fill out both fields.";  // Show error message
      });
    }
    // Check if the passwords match
    else if (password != confirmPassword) {
      setState(() {
        _errorText = "Passwords do not match.";  // Show mismatch error
      });
    }
    // If validation passes, navigate to the SuccessfulScreen
    else {
      setState(() {
        _errorText = null;  // Clear error message
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SuccessfulScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: CustomIconButton(),title: const Text("Set a New Password")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: "Create a new password. Ensure it differs from previous ones for security",
            ),
            const SizedBox(height: 10),

            const CustomText(
              text: "Password",
              color: Colors.black,
            ),
            CustomTextField(
              hintText: "Enter new password",
              controller: _passwordController,
              obscureText: true,
            ),

            const SizedBox(height: 10),
            const CustomText(
              text: "Confirm Password",
              color: Colors.black,
            ),
            CustomTextField(
              hintText: "Confirm new password",
              controller: _confirmPasswordController,
              obscureText: true,
            ),

            // Display error message if validation fails
            if (_errorText != null) ...[
              const SizedBox(height: 10),
              Text(
                _errorText!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],

            const SizedBox(height: 20),
            CustomButton(
              text: "Update Password",
              onTap: _handleUpdatePassword,  // Call the _handleUpdatePassword function on tap
            ),
          ],
        ),
      ),
    );
  }
}
