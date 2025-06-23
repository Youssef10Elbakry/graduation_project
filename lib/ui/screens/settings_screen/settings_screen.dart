import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/ui/screens/settings_screen/logout_button.dart';
import 'package:graduation_project/ui/screens/settings_screen/settings_box_container1.dart';
import 'package:graduation_project/ui/screens/settings_screen/settings_box_container2.dart';

class SettingsScreen extends StatelessWidget {
  static String screenName = "Settings Screen";
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: height*0.033,),
          Row(
            children: [
              SizedBox(width: width*0.0487,),
              Text("Settings", style: TextStyle(fontFamily: "Montserrat", fontSize: 35, fontWeight: FontWeight.w700))
            ],
          ),
          SizedBox(height: height*0.022,),
          Row(
            children: [
              SizedBox(width: width*0.0487,),
              Text("Security", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
            ],
          ),
          SizedBox(height: height*0.022,),
          SettingsBoxContainer1(),
          SizedBox(height: height*0.0438,),
          Row(
            children: [
              SizedBox(width: width*0.0487,),
              Text("About us", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
            ],
          ),
          SizedBox(height: height*0.022,),
          SettingsBoxContainer2(),
          SizedBox(height: height*0.22,),
          LogoutButton()

        ],
      ),
    );
  }
}
