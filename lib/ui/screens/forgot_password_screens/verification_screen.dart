import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_icon_button.dart';
import '../widgets/custom_text.dart';
import 'new_password_screen.dart';
//THE CORRECT PASSWORD ✅✅✅✅✅✅✅✅✅✅✅00000✅✅✅✅✅✅✅✅✅✅✅✅
class VerificationScreen extends StatefulWidget {
  static const String routeName = '/verification_screen';
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  // Create TextEditingControllers for each TextField
  final TextEditingController _digit1Controller = TextEditingController();
  final TextEditingController _digit2Controller = TextEditingController();
  final TextEditingController _digit3Controller = TextEditingController();
  final TextEditingController _digit4Controller = TextEditingController();
  final TextEditingController _digit5Controller = TextEditingController();
  String? _errorMessage;

  // Create FocusNodes to control focus for each TextField
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();
  void _verifyCode(){
    String code = _digit1Controller.text + _digit2Controller.text + _digit3Controller.text + _digit4Controller.text + _digit5Controller.text;

    if(code == "00000"){
      Navigator.push(context,MaterialPageRoute(builder:(context)=> SetNewPasswordScreen())
      );

    }
    else{
      setState(() {
        _errorMessage = "The code you entered is incorrect";
      });
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: CustomIconButton(),title: const Text("Check your Email")),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             CustomText(text:
              "We sent a reset code to youssef@gmail.com, enter the 5 digit code that was sent to the email.",
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDigitInputField(_digit1Controller, _focusNode1, _focusNode2, null),
                _buildDigitInputField(_digit2Controller, _focusNode2, _focusNode3, _focusNode1),
                _buildDigitInputField(_digit3Controller, _focusNode3, _focusNode4, _focusNode2),
                _buildDigitInputField(_digit4Controller, _focusNode4, _focusNode5, _focusNode3),
                _buildDigitInputField(_digit5Controller, _focusNode5, null, _focusNode4),
              ],
            ),
            SizedBox(height: 10,),
            if(_errorMessage != null)...[
              SizedBox(height: 10,),
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red,fontSize: 20),
              )
            ],
            CustomButton(text: "Verify Code",
                onTap:_verifyCode

            ),
            SizedBox(height: 10,),
            RichText(
              text: TextSpan(
                text: "Haven’t got the email yet? ",
                style: const TextStyle(color: Color(0xFF989898), fontSize: 14),
                children: [
                  TextSpan(
                    text: "Resend email",
                    style: const TextStyle(color: Colors.blueAccent),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }

  // Helper method to build a TextField for each digit input
  Widget _buildDigitInputField(TextEditingController controller, FocusNode currentFocusNode, FocusNode? nextFocusNode, FocusNode? previousFocusNode) {
    return SizedBox(
      width: 50.0,
      child: TextField(
        controller: controller,
        focusNode: currentFocusNode,
        maxLength: 1,  // Limit the input to 1 character
        keyboardType: TextInputType.number,  // Numeric keyboard
        decoration: InputDecoration(
          counterText: "",  // Hide the default counter
          hintText: "_",  // Placeholder for empty input
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE1E1E1)),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && nextFocusNode != null) {
            // If the current TextField has a value, move focus to the next field
            FocusScope.of(context).requestFocus(nextFocusNode);
          } else if (value.isEmpty && previousFocusNode != null) {
            // If the value is empty and the user presses backspace, move focus to the previous field
            FocusScope.of(context).requestFocus(previousFocusNode);
          }
        },
        onEditingComplete: () {
          // Automatically move focus to the next field when editing is complete
          if (nextFocusNode != null) {
            FocusScope.of(context).requestFocus(nextFocusNode);
          }
        },

      ),
    );
  }
}
