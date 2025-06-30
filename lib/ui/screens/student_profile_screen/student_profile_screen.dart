import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_project/ui/providers/student_profile_tab_bar_provider.dart';
import 'package:graduation_project/ui/screens/student_profile_screen/attendance_tab_bar_view.dart';
import 'package:graduation_project/ui/screens/student_profile_screen/grades_tab_bar_view.dart';
import 'package:graduation_project/ui/screens/student_profile_screen/insights_tab_bar_view.dart';
import 'package:graduation_project/ui/screens/student_profile_screen/student_profile_appbar.dart';
import 'package:graduation_project/ui/screens/student_profile_screen/student_profile_balance_container.dart';
import 'package:graduation_project/ui/screens/student_profile_screen/student_profile_textfield.dart';
import 'package:graduation_project/ui/screens/student_profile_screen/tab_bar_container.dart';
import 'package:provider/provider.dart';

import '../../providers/student_profile_provider.dart';

class StudentProfileScreen extends StatefulWidget {
  static String screenName = "Student Profile Screen";
  StudentProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {

  late StudentProfileTabBarProvider provider;
  late StudentProfileProvider screenProvider;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  late String childId;



  @override
  void initState() {
    super.initState();

    // Delay API call to avoid triggering setState during widget build
    Future.microtask(() async {
      Provider.of<StudentProfileProvider>(context, listen: false).fetchStudentData(childId);
    });
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    childId = ModalRoute.of(context)!.settings.arguments as String;
    print("The child id in student profile screen $childId");
    provider = Provider.of(context);
    screenProvider = Provider.of<StudentProfileProvider>(context);
    final studentProfileModel = screenProvider.studentProfileModel;

    return Scaffold(
      body: screenProvider.isLoading? const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
            ],
          ),
        ],
      ):Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StudentProfileAppbar(name: studentProfileModel?.fullName,role: "Student",imageUrl: studentProfileModel?.profilePicture),
          SizedBox(height: height*0.022),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  StudentProfileTextfield(labelText: "Full Name", infoText: studentProfileModel?.fullName,),
                  SizedBox(height: height*0.01,),
                  StudentProfileTextfield(labelText: "Code", infoText: studentProfileModel?.code,),
                ],
              ),
              SizedBox(width: width*0.0487,),
              StudentProfileBalanceContainer(balance: studentProfileModel?.balance,)
            ],
          ),
          SizedBox(height: height*0.0109,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StudentProfileTextfield(labelText: "Grade", infoText: studentProfileModel?.grade,),
              SizedBox(width: width*0.0487,),
              StudentProfileTextfield(labelText: "Age", infoText: studentProfileModel?.age,),

            ],
          ),
          DefaultTabController(
            length: 3,
            child: Expanded(
              child: Column(
                children: [
                  SizedBox(height: height*0.0219,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(

                        width: width*0.8516,
                        height: height*0.0438,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xffE7E7E7))
                        ),
                        child: TabBar(
                          unselectedLabelColor: const Color(0xff6D6D6D),
                          labelColor: Colors.white,
                          dividerColor: Colors.transparent,
                          indicatorWeight: 0.00000000001,
                            indicatorColor: Colors.transparent,
                            onTap: (val){
                            provider.changeTabColor(val);
                            },
                            tabs: [TabBarContainer(tabText: "Attendance", tabColor: provider.tab1Color,),
                              TabBarContainer(tabText: "Grades", tabColor: provider.tab2Color,),
                              TabBarContainer(tabText: "Insights", tabColor: provider.tab3Color,)]),
                      ),
                    ],
                  ),
                  SizedBox(height: height*0.0328,),
                  Expanded(child: TabBarView(children: [AttendanceTabBarView(childId: childId, records: studentProfileModel!.attendanceRecords,), GradesTabBarView(id: childId,), InsightsTabBarView()]))

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
