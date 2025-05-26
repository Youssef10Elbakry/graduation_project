import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class TransactionTrendChart extends StatelessWidget {
  final List<FlSpot> chartData;
  final List<String> monthLabels;

  const TransactionTrendChart({
    super.key,
    required this.chartData,
    required this.monthLabels,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate min and max Y values from actual data
    double minY = 0; // Default to 0 as minimum
    double maxY = 100; // Default max
    
    if (chartData.isNotEmpty) {
      // Find the actual min and max
      minY = chartData.map((spot) => spot.y).reduce(min);
      maxY = chartData.map((spot) => spot.y).reduce(max);
      
      // Make sure we have reasonable min/max values
      if (minY >= 0 && maxY > 0) {
        // All positive values
        minY = 0;
        maxY = maxY * 1.2; // Add 20% padding
      } else if (minY < 0 && maxY <= 0) {
        // All negative values
        maxY = 0;
        minY = minY * 1.2; // Add 20% padding for negatives
      } else {
        // Mixed positive and negative
        minY = minY * 1.2; // Add padding to both ends
        maxY = maxY * 1.2;
      }
      
      // Ensure we don't have zero range
      if (maxY - minY < 10) {
        maxY = minY + 10;
      }
    }
    
    // Round the min/max to nice values
    minY = (minY / 10).floor() * 10;
    maxY = (maxY / 10).ceil() * 10;
    
    // Calculate a reasonable interval
    double range = maxY - minY;
    double interval = range / 5; // Aim for about 5 lines
    
    // Round interval to a nice number
    if (interval < 1) {
      interval = 1;
    } else if (interval < 5) {
      interval = 5;
    } else if (interval < 10) {
      interval = 10;
    } else if (interval < 50) {
      interval = 50;
    } else if (interval < 100) {
      interval = 100;
    } else {
      interval = (interval / 100).ceil() * 100;
    }

    return Container(
      height: 260,
      margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaction Trends',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2F2F2F),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Monthly overview',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: interval,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(0.15),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50,
                      getTitlesWidget: (value, meta) {
                        // Don't show if very close to min or max (avoids overlap)
                        if ((value - minY).abs() < interval/10 || (value - maxY).abs() < interval/10) {
                          return const SizedBox.shrink();
                        }
                        
                        // Format the value nicely
                        String label = '\$${value.toInt()}';
                        
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            label,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      },
                      interval: interval,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final int index = value.toInt();
                        if (index < 0 || index >= monthLabels.length) {
                          return const Text('');
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            monthLabels[index],
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      },
                      interval: 1,
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: chartData.isEmpty ? 5 : chartData.length - 1.0,
                minY: minY,
                maxY: maxY,
                lineTouchData: LineTouchData(
                  enabled: true,
                  touchTooltipData: LineTouchTooltipData(
                    fitInsideHorizontally: true,
                    fitInsideVertically: true,
                    getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                      return touchedBarSpots.map((barSpot) {
                        final flSpot = barSpot;
                        final int index = flSpot.x.toInt();
                        String month = index >= 0 && index < monthLabels.length 
                            ? monthLabels[index] 
                            : '';
                            
                        return LineTooltipItem(
                          '$month\n\$${flSpot.y.toStringAsFixed(0)}',
                          const TextStyle(color: Colors.white),
                        );
                      }).toList();
                    },
                  ),
                  touchCallback: (FlTouchEvent event, LineTouchResponse? touchResponse) {},
                  handleBuiltInTouches: true,
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: chartData,
                    isCurved: true,
                    curveSmoothness: 0.35,
                    gradient: const LinearGradient(
                      colors: [Color(0xff2e66f6), Color(0xff5ec1fb)],
                    ),
                    barWidth: 4,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 6,
                          color: Colors.white,
                          strokeWidth: 3,
                          strokeColor: Color(0xff5ec1fb),
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff2e66f6).withOpacity(0.3),
                          Color(0xff5ec1fb).withOpacity(0.1),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
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
}