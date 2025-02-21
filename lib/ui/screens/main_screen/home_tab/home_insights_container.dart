import 'package:flutter/cupertino.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
class HomeInsightsContainer extends StatefulWidget {
  String title;
  int num;
  HomeInsightsContainer({super.key, required this.title, required this.num});

  @override
  State<HomeInsightsContainer> createState() => _HomeInsightsContainerState();
}

class _HomeInsightsContainerState extends State<HomeInsightsContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              Text(widget.num.toString(), style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),),
            ],
          ),
          const Spacer(),
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
                    value: 10,
                    color: Colors.blue,
                    radius: 12,
                  ),
                  PieChartSectionData(
                    showTitle: false,
                    value: 80,
                    color: Colors.purple,
                    radius: 12,
                  ),
                  PieChartSectionData(
                    showTitle: false,
                    value: 10,
                    color: Colors.orange,
                    radius: 12,
                  ),
                ],
              ),

            ),
          ),
        ],
      ),
    );
  }
}
