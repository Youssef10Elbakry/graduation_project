import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/ui/providers/student_profile_tab_bar_provider.dart';
import 'package:graduation_project/ui/screens/student_profile_screen/attendance_tab_bar_view.dart';
import 'package:graduation_project/ui/screens/student_profile_screen/student_profile_appbar.dart';
import 'package:graduation_project/ui/screens/student_profile_screen/student_profile_balance_container.dart';
import 'package:graduation_project/ui/screens/student_profile_screen/student_profile_textfield.dart';
import 'package:graduation_project/ui/screens/student_profile_screen/tab_bar_container.dart';
import 'package:provider/provider.dart';

class StudentProfileScreen extends StatefulWidget {
  static String screenName = "Student Profile Screen";
  StudentProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  late StudentProfileTabBarProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StudentProfileAppbar(name: "Deif Mohamed Ahmed",role: "Student",imageUrl: "ww"),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  StudentProfileTextfield(labelText: "Full Name", infoText: "Mahmoud Ayman",),
                  SizedBox(height: 10,),
                  StudentProfileTextfield(labelText: "Code", infoText: "211001811",),
                ],
              ),
              SizedBox(width: 20,),
              StudentProfileBalanceContainer()
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StudentProfileTextfield(labelText: "Grade", infoText: "5th",),
              SizedBox(width: 20,),
              StudentProfileTextfield(labelText: "Age", infoText: "10",),

            ],
          ),
          DefaultTabController(
            length: 3,
            child: Expanded(
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(

                        width: 350,
                        height: 40,
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
                  SizedBox(height: 30,),
                  Expanded(child: TabBarView(children: [AttendanceTabBarView(), Icon(Icons.add), Icon(Icons.exposure_minus_1)]))
              
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
