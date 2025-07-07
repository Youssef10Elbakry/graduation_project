import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/ui/screens/settings_screen/settings_row.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsBoxContainer2 extends StatelessWidget {
  final Uri url = Uri.parse('https://www.facebook.com/share/1JotaK7yd7/');
  final Uri url1 = Uri.parse('https://www.instagram.com/youssufmahmoud?igsh=anFoanVlZ3g2OW52');
   SettingsBoxContainer2({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width*0.973,
      height: height*0.24,
      padding: EdgeInsets.symmetric(horizontal: width*0.0487, vertical: height*0.0252),
      decoration: BoxDecoration(
        color: Colors.white, // White background inside
        borderRadius: BorderRadius.circular(20), // Rounded corners
        border: Border.all(color: Colors.grey.shade300, width: 1.5), // Border only
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsRow(iconPath: "assets/images/star_icon.svg", text: "Rate Us", onClicked: () async {await launchUrl(url);},),
          const Spacer(),
          SettingsRow(iconPath: "assets/images/settings_facebook_icon.png", text: "Follow us on Facebook",onClicked: () async {await launchUrl(url);}),
          const Spacer(),
          SettingsRow(iconPath: "assets/images/settings_instagram_icon.png", text: "Follow us on Instagram", onClicked: () async {await launchUrl(url1);}),


        ],
      ),

    );
  }
}
