import 'package:flutter/cupertino.dart';

class TabBarContainer extends StatelessWidget {
  String tabText;
  Color tabColor;
  TabBarContainer({super.key, required this.tabText, required this.tabColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: tabColor, borderRadius: BorderRadius.circular(8),),
      child: Text(tabText),
    );
  }
}
