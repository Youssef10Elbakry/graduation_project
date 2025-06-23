import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VisaContainer extends StatefulWidget {
  double balance;
  VisaContainer({super.key, required this.balance});

  @override
  State<VisaContainer> createState() => _VisaContainerState();
}

class _VisaContainerState extends State<VisaContainer> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Image.asset("assets/images/visa_card.png"),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height*0.071,),
            Padding(
              padding:  EdgeInsets.only(left: width*0.0365),
              child: Text("Total Balance", style: TextStyle(fontFamily: "Montserrat",
                  fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white)),
            ),
            Padding(
              padding:  EdgeInsets.only(left: width*0.0365),
              child: Text("EGP ${widget.balance}", style: TextStyle(fontFamily: "Montserrat",
                  fontWeight: FontWeight.w800, fontSize: 40, color: Colors.white)),
            )


          ],
        )
      ],
    );
  }
}
