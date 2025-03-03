import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/models/home_tab_child_model.dart';
import 'package:graduation_project/ui/providers/home_tab_provider.dart';
import 'package:provider/provider.dart';

class ChildAvatar extends StatefulWidget {
  ChildAvatar({super.key, required this.childModel});
  HomeTabChildModel childModel;

  @override
  State<ChildAvatar> createState() => _ChildAvatarState();
}

class _ChildAvatarState extends State<ChildAvatar> {
  late HomeTabProvider homeTabProvider;
  @override
  Widget build(BuildContext context) {
    homeTabProvider = Provider.of(context);
    print(widget.childModel.id);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
      child: InkWell(
        onTap: (){
          homeTabProvider.onChildTapped(widget.childModel.id);
        },
        child: CircleAvatar(
          backgroundImage: NetworkImage(widget.childModel.profilePictureLink),
          radius: 36,
        ),
      ),
    );
  }
}
