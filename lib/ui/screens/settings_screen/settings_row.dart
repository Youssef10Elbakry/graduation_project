import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsRow extends StatefulWidget {
  String iconPath;
  String text;

   SettingsRow({super.key, required this.iconPath, required this.text});

  @override
  State<SettingsRow> createState() => _SettingsRowState();
}

class _SettingsRowState extends State<SettingsRow> {
  bool switchValue = true;

  bool useSvg = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if(widget.text == "Change passcode" ||
        widget.text == "Follow us on Facebook" || widget.text == "Follow us on Instagram"){
      useSvg = false;
    }
    else{
      useSvg = true;
    }
    print(useSvg);
    return Row(
      children: [
        useSvg?
        SvgPicture.asset(widget.iconPath): Image(image: AssetImage(widget.iconPath)),
        SizedBox(width: width*0.0487,),
        Text(widget.text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
        Spacer(),
        widget.text == "Biometric Authentication"?
            Switch(value: switchValue, onChanged: (bool value) {switchValue = value;
              setState(() {});},): SizedBox(width: 1,)
      ],
    );
  }
}
