import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudentProfileBalanceContainer extends StatelessWidget {
  StudentProfileBalanceContainer({super.key, required this.balance});
  String? balance;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width*0.34,
      height: height*0.131,
      decoration: BoxDecoration(color: const Color(0xff6156C8), borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Balance", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),),
          SizedBox(height: height*0.0077,),
          Text("EGP ${balance!}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 24),),
        ],
      ),
    );
  }
}
