import 'package:flutter/cupertino.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/ui/providers/home_tab_provider.dart';
import 'package:graduation_project/ui/screens/student_profile_screen/student_profile_screen.dart';
import 'package:provider/provider.dart';
class HomeInsightsContainer extends StatefulWidget {
  String id;
  String title;
  int num;
  double presentPercentage;
  double absentPercentage;
  double latePercentage;
  HomeInsightsContainer({super.key, required this.title, required this.num, this.id = "",
    this.presentPercentage = 0.0, this.absentPercentage = 0.0, this.latePercentage = 0.0});

  @override
  State<HomeInsightsContainer> createState() => _HomeInsightsContainerState();
}

class _HomeInsightsContainerState extends State<HomeInsightsContainer> {
  late HomeTabProvider homeTabProvider;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    homeTabProvider = Provider.of(context);
    return InkWell(
      onTap: (){
        if(widget.title == "Attendance"){
          Navigator.pushNamed(context, StudentProfileScreen.screenName, arguments: widget.id);
        }

      },
      child: Container(
        height: height*0.1127,
        width: width*0.915,
        padding:  EdgeInsets.symmetric(horizontal: width*0.0365, vertical: height*0.0164),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffD2D5DA)),
          borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          children: [
            Column(
              children: [
                Text(widget.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                Text("${widget.num.toString()} ${widget.title == "Attendance"?"%":"EG"}", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),),
              ],
            ),
            const Spacer(),
            widget.title == "Attendance"?
            SizedBox(
              height: height*0.1094,
              width: width*0.2433,
              child: PieChart(
                PieChartData(
                  titleSunbeamLayout: false,
                  sectionsSpace: 2,
                  centerSpaceRadius: width*0.0487,
                  sections: [
                    PieChartSectionData(
                      showTitle: false,
                      value: homeTabProvider.presentPercentage,
                      color: Colors.blue,
                      radius: width*0.0292,
                    ),
                    PieChartSectionData(
                      showTitle: false,
                      value: homeTabProvider.latePercentage,
                      color: Colors.purple,
                      radius: width*0.0292,
                    ),
                    PieChartSectionData(
                      showTitle: false,
                      value: homeTabProvider.absentPercentage,
                      color: Colors.orange,
                      radius: width*0.0292,
                    ),
                  ],
                ),

              ),
            ):const Text(""),
          ],
        ),
      ),
    );
  }
}
