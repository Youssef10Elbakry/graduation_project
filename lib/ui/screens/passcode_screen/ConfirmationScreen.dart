import 'package:flutter/material.dart';
import 'package:passcode_screeen/ui/providers/comfirmation_provider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passcode_screeen/ui/widgets/keypad_confirmation.dart';
import 'package:flutter_svg/flutter_svg.dart';



class ConfirmationScreen extends StatelessWidget {
  static const routeName = '/confirmation';

  const ConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final confirmationProvider = Provider.of<ConfirmationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: confirmationProvider.isConfirming
            ? IconButton(
                icon: SvgPicture.asset('assets/icons/back_black_icon.svg'),
                onPressed: () {
                  confirmationProvider.resetConfirmation();
                },
              )
            : null,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: Text(
                      confirmationProvider.isConfirming
                          ? 'Confirm the confirmation code'
                          : 'Enter your new confirmation code',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (confirmationProvider.isError)
                    const Text(
                      'Not Matched!',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  const SizedBox(height: 50),
                  // Confirmation placeholders
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      ConfirmationProvider.maxDigits,
                      (index) {
                        bool filled = index < confirmationProvider.enteredConfirmation.length;
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: filled ? Colors.black : Colors.grey[300],
                            shape: BoxShape.circle,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 60),
                  Expanded(
                    child: keypad_comf(
                      onDigitPressed: (digit) {
                        confirmationProvider.addDigit(digit, context);
                      },
                      onBackspacePressed: () {
                        confirmationProvider.removeLastDigit();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Loading Overlay
          if (confirmationProvider.isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
