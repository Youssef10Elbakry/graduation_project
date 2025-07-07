import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/ui/providers/announcements_tab_provider.dart';
import 'package:graduation_project/ui/screens/main_screen/announcements_tab/announcement_widget.dart';
import 'package:provider/provider.dart';

class AnnouncementsTab extends StatefulWidget {
  const AnnouncementsTab({super.key});

  @override
  State<AnnouncementsTab> createState() => _AnnouncementsTabState();
}

class _AnnouncementsTabState extends State<AnnouncementsTab> {
  late AnnouncementsTabProvider provider;
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      Provider.of<AnnouncementsTabProvider>(context, listen: false).getAnnouncements();
    });
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    provider = Provider.of(context);
    return provider.isLoading? const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
          ],
        ),
      ],
    ): RefreshIndicator(
      onRefresh: () async{Provider.of<AnnouncementsTabProvider>(context, listen: false).getAnnouncements();},
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: height*0.0328,),
            Row(
              children: [
                SizedBox(width: width*0.0365,),
                const Text("Announcements", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35, fontFamily: "Montserrat"),),

            ],),
            SizedBox(height: height*0.01641,),
            const Divider(),
            SizedBox(
              height: height*0.82,
                child: ListView.builder(itemCount: provider.announcements.length, itemBuilder: (context, index)=>AnnouncementWidget(provider.announcements[index])))
          ],
        ),
      ),
    );
  }
}
