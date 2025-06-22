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
    homeTabProvider = Provider.of(context);
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, StudentProfileScreen.screenName, arguments: widget.id);
      },
      child: Container(
        height: 103,
        width: 376,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
              height: 100,
              width: 100,
              child: PieChart(
                PieChartData(
                  titleSunbeamLayout: false,
                  sectionsSpace: 2,
                  centerSpaceRadius: 20,
                  sections: [
                    PieChartSectionData(
                      showTitle: false,
                      value: homeTabProvider.presentPercentage,
                      color: Colors.blue,
                      radius: 12,
                    ),
                    PieChartSectionData(
                      showTitle: false,
                      value: homeTabProvider.latePercentage,
                      color: Colors.purple,
                      radius: 12,
                    ),
                    PieChartSectionData(
                      showTitle: false,
                      value: homeTabProvider.absentPercentage,
                      color: Colors.orange,
                      radius: 12,
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
