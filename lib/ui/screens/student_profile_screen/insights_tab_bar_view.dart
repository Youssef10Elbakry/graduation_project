import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class InsightsTabBarView extends StatefulWidget {
  const InsightsTabBarView({Key? key}) : super(key: key);

  @override
  State<InsightsTabBarView> createState() => _InsightsTabBarViewState();
}

class _InsightsTabBarViewState extends State<InsightsTabBarView> {
  String attendanceType = 'Attendance';
  String timeFilter = 'Month';

  final List<String> attendanceOptions = ['Attendance'];
  final List<String> timeOptions = ['Week', 'Month', 'Year'];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                  DropdownButton<String>(
                    value: attendanceType,
                    underline: const SizedBox(),
                    items: attendanceOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        attendanceType = newValue!;
                      });
                    },
                  ),
                  DropdownButton<String>(
                    value: timeFilter,
                    underline: const SizedBox(),
                    items: timeOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        timeFilter = newValue!;
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
                    barGroups: [
                      _buildBar(0, 8, Colors.green),
                      _buildBar(1, 10, Colors.green),
                      _buildBar(2, 2, Colors.red),
                      _buildBar(3, 6, Colors.orange),
                      _buildBar(4, 7, Colors.orange),
                      _buildBar(5, 10, Colors.green),
                      _buildBar(6, 6, Colors.orange),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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

