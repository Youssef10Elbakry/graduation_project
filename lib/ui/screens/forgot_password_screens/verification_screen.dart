import 'package:flutter/material.dart';
import 'new_password_screen.dart';

class VerificationScreen extends StatefulWidget {
  final String email;
  final String token;
  final String pinAuth;

  const VerificationScreen({
    super.key,
    required this.email,
    required this.token,
    required this.pinAuth,
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController _codeController = TextEditingController();
  String? _errorText;
  bool _isLoading = false;

  Future<void> _verifyCode() async {
    final code = _codeController.text.trim();

    if (code.isEmpty) {
      setState(() {
        _errorText = "Please enter the verification code.";
      });
      return;
    }

    setState(() {
      _errorText = null;
      _isLoading = true;
    });

    try {
      if (code == widget.pinAuth) {
        // Navigate and pass email, token, and the entered OTP (pinAuth)
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SetNewPasswordScreen(
              email: widget.email,
              verificationCode: widget.pinAuth,
              token: widget.token,
            ),
          ),
        );
      } else {
        setState(() {
          _errorText = "Invalid code. Please try again.";
        });
      }
    } catch (e) {
      setState(() {
        _errorText = "An error occurred. Please try again.";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Code')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("A verification code was sent to ${widget.email}."),
            const SizedBox(height: 16),
            TextField(
              controller: _codeController,
              decoration: const InputDecoration(labelText: "Enter Code"),
              keyboardType: TextInputType.number,
            ),
            if (_errorText != null) ...[
              const SizedBox(height: 8),
              Text(
                _errorText!,
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 16),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _verifyCode,
              child: const Text("Verify"),
            ),
          ],
        ),
      ),
    );
  }
}
