import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/ui/screens/settings_screen/settings_box_container1.dart';
import 'package:graduation_project/ui/screens/settings_screen/settings_box_container2.dart';

class SettingsScreen extends StatelessWidget {
  static String screenName = "Settings Screen";
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30,),
          Row(
            children: [
              SizedBox(width: 20,),
              Text("Settings", style: TextStyle(fontFamily: "Montserrat", fontSize: 35, fontWeight: FontWeight.w700))
            ],
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              SizedBox(width: 20,),
              Text("Security", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
            ],
          ),
          SizedBox(height: 20,),
          SettingsBoxContainer1(),
          SizedBox(height: 40,),
          Row(
            children: [
              SizedBox(width: 20,),
              Text("About us", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
            ],
          ),
          SizedBox(height: 20,),
          SettingsBoxContainer2()

        ],
      ),
    );
  }
}
