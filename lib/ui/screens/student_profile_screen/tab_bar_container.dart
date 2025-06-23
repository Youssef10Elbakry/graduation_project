import 'package:flutter/cupertino.dart';

class TabBarContainer extends StatelessWidget {
  String tabText;
  Color tabColor;
  TabBarContainer({super.key, required this.tabText, required this.tabColor});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width*0.29197,
      height: height*0.033,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: tabColor, borderRadius: BorderRadius.circular(8),),
      child: Text(tabText),
    );
  }
}
