import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class keypad_comf extends StatelessWidget {
  final ValueChanged<String> onDigitPressed;
  final VoidCallback onBackspacePressed;

  const keypad_comf({
    Key? key,
    required this.onDigitPressed,
    required this.onBackspacePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      childAspectRatio: 1.2,
      children: [
        for (var i = 1; i <= 9; i++)
          _keypad_comfButton(
            label: '$i',
            onTap: () => onDigitPressed('$i'),
          ),
          TextButton(
            onPressed: () {
            },
            child: Text('')
          
          ),
        _keypad_comfButton(
          label: '0',
          onTap: () => onDigitPressed('0'),
        ),
        // Backspace
        _keypad_comfButton(
          icon: Icons.backspace_outlined,
          onTap: onBackspacePressed,
        ),
      ],
    );
  }
}

class _keypad_comfButton extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final VoidCallback onTap;

  const _keypad_comfButton({
    Key? key,
    this.label,
    this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (icon != null) {
      child = Icon(icon, size: 24, color: Colors.black);
    } else {
      child = Text(
        label ?? '',
        style: GoogleFonts.inter(
          fontSize: 32,
          fontWeight: FontWeight.w300, // Thin weight
        ),
      );
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(40),
      child: Container(
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
