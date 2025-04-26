import 'package:flutter/material.dart';
class CustomIconButton extends StatelessWidget {
  const CustomIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      // Use Navigator.pop() to go back to the previous screen
      onPressed: () {
        Navigator.pop(context);  // This will pop the current screen and go back to the previous one
      },
      icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
    );;
  }
}
