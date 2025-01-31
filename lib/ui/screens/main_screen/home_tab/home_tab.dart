import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: screenHeight*0.021,),
        Row(
          children: [
            SizedBox(width: screenWidth*0.0446,),
            Image.asset("assets/images/mahmoud_home.png"),
            SizedBox(width: screenWidth*0.0117,),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome Back,", style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12, fontWeight: FontWeight.w400, fontFamily: "Prompt"
                ),),
                Text("Mahmoud Ayman", style: TextStyle(
                  color: Color(0xff000000),
                    fontSize: 16, fontWeight: FontWeight.w400, fontFamily: "Prompt",
                ),)
              ],
            )
          ],
        ),
        SizedBox(height: 40,),
        Center(child: Image.asset("assets/images/football_courts.png")),
        SizedBox(height: 25,),
        Row(
          children: [
            SizedBox(width: screenWidth*0.089,),
            Text("Children", style: TextStyle(
              color: Colors.black,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
              fontSize: 25
            ),),
          ],
        )
      ],
    );
  }
}
