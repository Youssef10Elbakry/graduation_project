import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/models/announcement_model.dart';
import 'package:graduation_project/ui/providers/announcement_widget_provider.dart';
import 'package:graduation_project/ui/providers/announcements_tab_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AnnouncementWidget extends StatefulWidget {
  AnnouncementModel announcement;

  AnnouncementWidget(this.announcement, {super.key});

  @override
  State<AnnouncementWidget> createState() => _AnnouncementWidgetState();
}

class _AnnouncementWidgetState extends State<AnnouncementWidget> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String formattedDate = DateFormat('yyyy, MMM dd, h:mm a').format(widget.announcement.createdAt);
    return ChangeNotifierProvider(
      create: (_)=>AnnouncementWidgetProvider(),
      child: Consumer<AnnouncementWidgetProvider>(
        builder: (context, provider, _)=>Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: width*0.0365, vertical: height*0.01094),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CircleAvatar(
                  //   onBackgroundImageError: (_,d){
                  //     print("Error in loading image");
                  //   },
                  //   backgroundImage: NetworkImage(""),
                  //   radius: width*0.0681,
                  // ),
                  SizedBox(width: width*0.02433,),
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.announcement.title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: width*0.0389),),
                        Text(formattedDate.toString(), style: TextStyle(fontSize: width*0.0292, color: Colors.grey, fontWeight: FontWeight.w400),),
                        SizedBox(height: height*0.00875,),
                        provider.isExpanded?Text(widget.announcement.message,softWrap: true,): const SizedBox(width: 1,)
                      ],
                    ),
                  ),
                  const Spacer(flex: 1,),
                  IconButton(onPressed: provider.showAndHideAnnouncementMessage, icon: Icon(provider.isExpanded? Icons.keyboard_arrow_down: Icons.keyboard_arrow_up))
                ],
              ),
              SizedBox(height: height*0.01094,),
              const Divider()
            ],
          ),
        ),
      ),
    );
  }
}
