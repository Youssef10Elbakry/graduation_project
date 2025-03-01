import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChildAvatar extends StatefulWidget {
  const ChildAvatar({super.key});

  @override
  State<ChildAvatar> createState() => _ChildAvatarState();
}

class _ChildAvatarState extends State<ChildAvatar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(width: 20,),
        CircleAvatar(
          backgroundImage: AssetImage("assets/images/deif_circle_avatar.png"),
          radius: 36,
        ),
        SizedBox(width: 20,),
      ],
    );
  }
}
