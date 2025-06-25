import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsRow extends StatefulWidget {
  String iconPath;
  String text;
  Function() onClicked;

   SettingsRow({super.key, required this.iconPath, required this.text, required this.onClicked});

  @override
  State<SettingsRow> createState() => _SettingsRowState();
}

class _SettingsRowState extends State<SettingsRow> {
  bool switchValue = true;

  bool useSvg = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if(widget.text == "Change passcode" ||
        widget.text == "Follow us on Facebook" || widget.text == "Follow us on Instagram"){
      useSvg = false;
    }
    else{
      useSvg = true;
    }

    return InkWell(
      onTap: widget.onClicked,
      child: Row(
        children: [
          useSvg?
          SvgPicture.asset(widget.iconPath): Image(image: AssetImage(widget.iconPath)),
          SizedBox(width: width*0.0487,),
          Text(widget.text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
          const Spacer(),
         const SizedBox(width: 1,)
        ],
      ),
    );
  }
}
