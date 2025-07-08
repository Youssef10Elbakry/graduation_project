import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_project/ui/providers/home_tab_provider.dart';
import 'package:graduation_project/ui/widgets/grades_button.dart';
import 'package:graduation_project/ui/widgets/child_avatar.dart';
import 'package:graduation_project/ui/screens/main_screen/home_tab/home_insights_container.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
   const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late HomeTabProvider provider;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();


  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      Provider.of<HomeTabProvider>(context, listen: false).getChildren();
      Provider.of<HomeTabProvider>(context, listen: false).getParentProfileData();
    });
  }
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<HomeTabProvider>(context);
    print("Parent profile picture link ${provider.parentProfilePictureLink}");
    print("Children in the home tab: ${provider.children}");
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    print("Screen height in home tab $screenHeight");

    return RefreshIndicator(
      onRefresh: ()async {
        Provider.of<HomeTabProvider>(context, listen: false).getChildren();
        Provider.of<HomeTabProvider>(context, listen: false).getParentProfileData();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight*0.022,),
            Row(
              children: [
                SizedBox(width: screenWidth*0.0446,),
                CircleAvatar(backgroundImage: NetworkImage(provider.parentProfilePictureLink),),
                SizedBox(width: screenWidth*0.0117,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Welcome Back,", style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12, fontWeight: FontWeight.w400, fontFamily: "Prompt"
                    ),),
                    Text(provider.parentUsername, style: const TextStyle(
                      color: Color(0xff000000),
                        fontSize: 16, fontWeight: FontWeight.w400, fontFamily: "Prompt",
                    ),)
                  ],
                )
              ],
            ),
            SizedBox(height: screenHeight*0.0438,),
            Center(child: Image.asset("assets/images/football_courts.png")),
            SizedBox(height: screenHeight*0.02626,),
            Row(
              children: [
                SizedBox(width: screenWidth*0.089,),
                const Text("Children", style: TextStyle(
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

            SizedBox(height: screenHeight*0.022),
            SizedBox(
              height: screenHeight*0.287,
              child: Visibility(
                visible: provider.insightsVisible,
                child: SingleChildScrollView(
                  child: Column(children: [
                    Row(
                      children: [
                        SizedBox(width: screenWidth*0.069,),
                        const Text("Insights", style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            fontSize: 20
                        ),),
                      ],
                    ),
                    SizedBox(height: screenHeight*0.03676,),
                    Center(child: HomeInsightsContainer(title: "Attendance", id: provider.childId, num: provider.attendancePercentage,
                    presentPercentage: provider.presentPercentage, absentPercentage: provider.absentPercentage,
                      latePercentage: provider.latePercentage,)),
                    SizedBox(height: screenHeight*0.015756,),
                    Center(child: HomeInsightsContainer(title: "Expenses", num: provider.expendiences,)),
                    SizedBox(height: screenHeight*0.015756,),
                    GradesButton(id: provider.childId),

                  ],),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
