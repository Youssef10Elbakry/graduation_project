import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/ui/screens/settings_screen/settings_row.dart';

class SettingsBoxContainer1 extends StatelessWidget {
  const SettingsBoxContainer1({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 400,
      height: 145,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 23),
      decoration: BoxDecoration(
        color: Colors.white, // White background inside
        borderRadius: BorderRadius.circular(20), // Rounded corners
        border: Border.all(color: Colors.grey.shade300, width: 1.5), // Border only
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsRow(iconPath: "assets/images/passcode_icon.png", text: "Change passcode"),
          Spacer(),
          SettingsRow(iconPath: "assets/images/settings_biometric_icon.svg", text: "Biometric Authentication"),
        ],
      ),

    );
  }
}
