import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/insights_tab_bar_view_provider.dart';

class InsightsTabBarView extends StatefulWidget {

  const InsightsTabBarView({Key? key}) : super(key: key);

  @override
  State<InsightsTabBarView> createState() => _InsightsTabBarViewState();
}

class _InsightsTabBarViewState extends State<InsightsTabBarView> {


  late InsightsTabBarViewProvider provider;


  String attendanceType = 'Attendance';
  String timeFilter = 'Semester';

  final List<String> attendanceOptions = ['Attendance'];
  final List<String> timeOptions = ['Semester', 'Year'];

  @override
  void initState() {
    super.initState();

    // Delay API call to avoid triggering setState during widget build
    Future.microtask(() async {
      Provider.of<InsightsTabBarViewProvider>(context, listen: false).getAttendanceToShowDetails();
    });
  }

  @override
  Widget build(BuildContext context) {

    provider = Provider.of(context);
    print(provider.attendanceToShowColors);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if(provider.attendanceToShow.isEmpty || provider.attendanceToShowColors.isEmpty){
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
            ],
          ),
        ],
      );
    }
    else{
      return Padding(
        padding: EdgeInsets.all(width*0.0389),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(width*0.0389),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 6),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width*0.0389, vertical: height*0.00875),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Attendance", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                    // DropdownButton<String>(
                    //   value: attendanceType,
                    //   underline: const SizedBox(),
                    //   items: attendanceOptions.map((String value) {
                    //     return DropdownMenuItem<String>(
                    //       value: value,
                    //       child: Text(value),
                    //     );
                    //   }).toList(),
                    //   onChanged: (newValue) {
                    //     setState(() {
                    //       attendanceType = newValue!;
                    //     });
                    //   },
                    // ),
                    DropdownButton<String>(
                      value: provider.timeFilter,
                      underline: const SizedBox(),
                      items: timeOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          provider.changeTimeFilter(newValue!);
                        });
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding:  EdgeInsets.all(width*0.0389),
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
                              return Text(days[value.toInt()]);
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      gridData: FlGridData(show: false),
                      barGroups: List.generate(7, (index)=>_buildBar(index, provider.attendanceToShow[index].toDouble(), provider.attendanceToShowColors[index])),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

  }

  BarChartGroupData _buildBar(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: 30,
          color: color,
          borderRadius: BorderRadius.circular(50),  // Fully rounded edges
        ),
      ],
    );
  }
}

