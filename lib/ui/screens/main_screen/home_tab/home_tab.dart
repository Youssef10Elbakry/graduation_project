import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_project/ui/providers/home_tab_provider.dart';
import 'package:graduation_project/ui/screens/main_screen/widgets/child_avatar.dart';
import 'package:graduation_project/ui/screens/main_screen/home_tab/home_insights_container.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
   HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late HomeTabProvider provider;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();


  void initState() {
    super.initState();

    // Delay API call to avoid triggering setState during widget build
    Future.microtask(() async {
      final String token = (await secureStorage.read(key: "authentication_key"))!;
      Provider.of<HomeTabProvider>(context, listen: false).getChildren();
      print("Token: $token");
    });
  }
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<HomeTabProvider>(context);
    print("Children in the home tab: ${provider.children}");
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20,),
        Row(
          children: [
            SizedBox(width: screenWidth*0.0446,),
            Image.asset("assets/images/mahmoud_home.png"),
            SizedBox(width: screenWidth*0.0117,),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome Back,", style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12, fontWeight: FontWeight.w400, fontFamily: "Prompt"
                ),),
                Text("Mahmoud Ayman", style: TextStyle(
                  color: Color(0xff000000),
                    fontSize: 16, fontWeight: FontWeight.w400, fontFamily: "Prompt",
                ),)
              ],
            )
          ],
        ),
        SizedBox(height: 40,),
        Center(child: Image.asset("assets/images/football_courts.png")),
        SizedBox(height: screenHeight*0.02626,),
        Row(
          children: [
            SizedBox(width: screenWidth*0.089,),
            Text("Children", style: TextStyle(
              color: Colors.black,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
              fontSize: 25
            ),),
          ],
        ),
        SizedBox(height: screenHeight*0.02226,),
        provider.isLoadingChildren?const Row(
          children: [
            Spacer(),
            CircularProgressIndicator(),
            Spacer()
          ],
        ):
        SizedBox(
          height: screenHeight*0.084,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.only(left: screenWidth*0.089),
              child: Row(
                // mainAxisSize: MainAxisSize.max,
                children: List.generate(provider.children.length, (index) { // Change 5 to any number
                  return ChildAvatar(childModel: provider.children[index], inHomeTab: true,);
                  })
                      ),
            ),
          )),

        SizedBox(height: 20),
        Visibility(
          visible: provider.insightsVisible,
          child: Column(children: [
            Row(
              children: [
                SizedBox(width: screenWidth*0.089,),
                Text("Insights", style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                ),),
              ],
            ),
            SizedBox(height: screenHeight*0.03676,),
            Center(child: HomeInsightsContainer(title: "Attendance", num: provider.attendancePercentage,
            presentPercentage: provider.presentPercentage, absentPercentage: provider.absentPercentage,
              latePercentage: provider.latePercentage,)),
            SizedBox(height: screenHeight*0.015756,),
            Center(child: HomeInsightsContainer(title: "Expediences", num: provider.expendiences,))
          ],),
        )
      ],
    );
  }
}
