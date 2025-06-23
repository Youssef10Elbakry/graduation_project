import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/models/child_model.dart';
import 'package:graduation_project/ui/providers/home_tab_provider.dart';
import 'package:graduation_project/ui/providers/wallet_tab_provider.dart';
import 'package:provider/provider.dart';

class ChildAvatar extends StatefulWidget {
  ChildAvatar({super.key, required this.childModel, required this.inHomeTab});
  ChildModel childModel ;
  bool inHomeTab;

  @override
  State<ChildAvatar> createState() => _ChildAvatarState();

}

class _ChildAvatarState extends State<ChildAvatar> {
  @override
  void initState(){
    super.initState();


  }
  late HomeTabProvider homeTabProvider;
  late WalletTabProvider walletTabProvider;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    homeTabProvider = Provider.of(context);
    walletTabProvider = Provider.of(context);
    print(widget.childModel.id);
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: width*0.0365, vertical: 0),
      child: InkWell(
        onTap: (){
          if(widget.inHomeTab){
            homeTabProvider.onChildTapped(widget.childModel.id);
          }
          else{
            walletTabProvider.onChildTapped(widget.childModel.id, widget.childModel.username, widget.childModel.profilePictureLink);
          }

        },
        child: CircleAvatar(
          onBackgroundImageError: (_,d){
            print("Error in loading image");
          },
          backgroundImage: NetworkImage(widget.childModel.profilePictureLink),
          radius: width*0.0876,
        ),
      ),
    );
  }
}
