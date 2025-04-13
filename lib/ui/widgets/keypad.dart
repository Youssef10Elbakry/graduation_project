import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Global key for accessing context in dialogs
final GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

class Keypad extends StatelessWidget {
  final void Function(String)? onDigitPressed;
  final VoidCallback? onBackspacePressed;

  const Keypad({
    Key? key,
    required this.onDigitPressed,
    required this.onBackspacePressed,
  }) : super(key: key);

  Widget _buildButton(BuildContext context, String text, {bool isBackspace = false, bool isForget = false}) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isBackspace 
              ? onBackspacePressed 
              : isForget 
                  ? () {
                      // Show forget dialog
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 16),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Warning!',
                                            style: GoogleFonts.inter(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'This will log you out of your account to start the reset passcode process!',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.inter(
                                              fontSize: 16,
                                              color: Colors.grey[600],
                                              height: 1.5,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Are you sure you want to continue?',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.inter(
                                              fontSize: 16,
                                              color: const Color.fromARGB(255, 0, 0, 0),
                                              height: 1.5,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 24),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed: () => Navigator.pop(context),
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.grey[200],
                                                    foregroundColor: Colors.black87,
                                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                    elevation: 0,
                                                  ),
                                                  child: Text(
                                                    'Cancel',
                                                    style: GoogleFonts.inter(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    
                                                    Navigator.pop(context);
                                                    Navigator.pushReplacementNamed(context, '/confirmation');
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: const Color(0xFFFF9500),
                                                    foregroundColor: Colors.white,
                                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                    elevation: 0,
                                                  ),
                                                  child: Text(
                                                    'OK',
                                                    style: GoogleFonts.inter(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: -40,
                                      child: Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFFF9500),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.warning_rounded,
                                          color: Colors.white,
                                          size: 32,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  : () => onDigitPressed?.call(text),
          borderRadius: BorderRadius.circular(40),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Center(
              child: isBackspace
                  ? const Icon(Icons.backspace_outlined, color: Colors.black, size: 24)
                  : isForget
                      ? Text(
                          text,
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1F41BB),
                          ),
                        )
                      : Text(
                          text,
                          style: GoogleFonts.inter(
                            fontSize: 32,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                        ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
       mainAxisSpacing: 45,
      crossAxisSpacing: 40,
      childAspectRatio: 1.2,
      children: [
        _buildButton(context, '1'),
        _buildButton(context, '2'),
        _buildButton(context, '3'),
        _buildButton(context, '4'),
        _buildButton(context, '5'),
        _buildButton(context, '6'),
        _buildButton(context, '7'),
        _buildButton(context, '8'),
        _buildButton(context, '9'),
        _buildButton(context, 'Forget?', isForget: true),
        _buildButton(context, '0'),
        _buildButton(context, '', isBackspace: true),
      ],
    );
  }
}
