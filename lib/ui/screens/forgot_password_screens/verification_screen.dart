import 'package:flutter/material.dart';
import 'package:graduation_project/ui/widgets/custom_button.dart';
import 'package:graduation_project/ui/widgets/custom_icon_button.dart';
import 'package:graduation_project/ui/widgets/custom_text.dart';
import 'package:graduation_project/ui/widgets/custom_text_field.dart';
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
  final List<TextEditingController> _controllers =
  List.generate(5, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());
  List<bool> _isFilled = List.generate(5, (_) => false);

  String? _errorText;
  bool _isLoading = false;

  Future<void> _verifyCode() async {
    String code = _controllers.map((c) => c.text).join();

    if (code.isEmpty || code.length < 5) {
      setState(() {
        _errorText = "Please enter the full 5-digit verification code.";
      });
      return;
    }

    setState(() {
      _errorText = null;
      _isLoading = true;
    });

    try {
      if (code == widget.pinAuth) {
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

  InputDecoration _buildDecoration(int index) {
    final bool filled = _isFilled[index];
    return InputDecoration(
      hintText: '',
      counterText: '', // Removes the "0/1"
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: filled ? Colors.blue : Colors.grey,
          width: 2.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(
          color: Colors.blue,
          width: 2.0
        ),
      ),
    );
  }

  Widget _buildCodeField(int index) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        maxLength: 1,
        keyboardType: TextInputType.number,
        decoration: _buildDecoration(index),
        onChanged: (value) {
          setState(() {
            _isFilled[index] = value.isNotEmpty;
          });

          if (value.isNotEmpty && index < 4) {
            FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(20),
          child: CustomIconButton(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Check your email",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                children: [
                  const TextSpan(text: "A verification code was sent to "),
                  TextSpan(
                    text: widget.email,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: ". Enter the 5 digits mentioned in the email."),
                ],
              ),
            ),

            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(5, (index) => _buildCodeField(index)),
            ),
            if (_errorText != null) ...[
              const SizedBox(height: 8),
              Text(
                _errorText!,
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 24),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : CustomButton(
              text: "Verify Code",
              onTap: _verifyCode,
            ),
            SizedBox(height:20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Haven’t got the email yet?",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800], // Dark grey
                  ),
                ),
                const SizedBox(width: 5),
                // GestureDetector(
                //   onTap: () {
                //     print("Resend email tapped");
                //   },
                //   child: Text(
                //     "Resend to email",
                //     style: TextStyle(
                //       fontSize: 16,
                //       color: const Color(0xFF1F41BB),
                //       decoration: TextDecoration.underline,
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ),
                // ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
