import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../models/grade_models.dart';

class GradeTimelineWidget extends StatelessWidget {
  final List<GradeProgress> gradeProgress;

  const GradeTimelineWidget({
    super.key,
    required this.gradeProgress,
  });

  @override
  Widget build(BuildContext context) {
    if (gradeProgress.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Grade Timeline',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Grade Progression',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: false,
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        const style = TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        );
                        
                        if (value.toInt() >= 0 && value.toInt() < gradeProgress.length) {
                          final date = gradeProgress[value.toInt()].date;
                          final month = DateFormat('MMM').format(date);
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              month,
                              style: style,
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                minX: 0,
                maxX: (gradeProgress.length - 1).toDouble(),
                minY: _getMinY(),
                maxY: _getMaxY(),
                lineBarsData: [
                  LineChartBarData(
                    spots: _generateSpots(),
                    isCurved: true,
                    color: const Color(0xFF6B73FF),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: const Color(0xFF6B73FF),
                          strokeWidth: 2,
                          strokeColor: Colors.white,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<FlSpot> _generateSpots() {
    List<FlSpot> spots = [];
    
    for (int i = 0; i < gradeProgress.length; i++) {
      spots.add(FlSpot(i.toDouble(), gradeProgress[i].percentage));
    }
    
    return spots;
  }

  double _getMinY() {
    if (gradeProgress.isEmpty) return 0;
    double min = gradeProgress.first.percentage;
    for (var progress in gradeProgress) {
      if (progress.percentage < min) {
        min = progress.percentage;
      }
    }
    return (min - 5).clamp(0, 100); // Add some padding and ensure it's not below 0
  }

  double _getMaxY() {
    if (gradeProgress.isEmpty) return 100;
    double max = gradeProgress.first.percentage;
    for (var progress in gradeProgress) {
      if (progress.percentage > max) {
        max = progress.percentage;
      }
    }
    return (max + 5).clamp(0, 100); // Add some padding and ensure it's not above 100
  }
} 