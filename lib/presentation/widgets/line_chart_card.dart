import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sipeb/data/models/permintaan_model.dart';

import 'custom_card.dart';

class LineChartCard extends StatelessWidget {
  LineChartCard({super.key, required this.thisYearData});

  final List<PermintaanModel> thisYearData;

  final List<FlSpot> spots = [];

  final leftTitle = {
    0: '0',
    10: '10',
    20: '20',
    30: '30',
    40: '40',
    50: '50',
  };
  final bottomTitle = {
    0: 'Jan',
    10: 'Feb',
    20: 'Mar',
    30: 'Apr',
    40: 'May',
    50: 'Jun',
    60: 'Jul',
    70: 'Aug',
    80: 'Sep',
    90: 'Oct',
    100: 'Nov',
    110: 'Dec',
  };

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < 120; i += 10) {
      spots.add(
        FlSpot(
          i.toDouble(),
          thisYearData
              .where((element) => element.date.month == i / 10 + 1)
              .length
              .toDouble(),
        ),
      );
    }

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "PB-16 Setiap Bulan",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AspectRatio(
              aspectRatio: 16 / 6,
              child: LineChart(
                LineChartData(
                  lineTouchData: LineTouchData(
                    handleBuiltInTouches: true,
                  ),
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 32,
                        interval: 10,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return bottomTitle[value.toInt()] != null
                              ? SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  space: 10,
                                  child: Text(
                                      bottomTitle[value.toInt()].toString(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[400])),
                                )
                              : const SizedBox();
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return leftTitle[value.toInt()] != null
                              ? Text(leftTitle[value.toInt()].toString(),
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey[400]))
                              : const SizedBox();
                        },
                        showTitles: true,
                        interval: 1,
                        reservedSize: 20,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  lineBarsData: [
                    LineChartBarData(
                        isCurved: true,
                        curveSmoothness: 0,
                        color: Colors.green,
                        barWidth: 2.5,
                        isStrokeCapRound: true,
                        belowBarData: BarAreaData(
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.green,
                              Colors.transparent,
                            ],
                          ),
                          show: true,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                        ),
                        dotData: FlDotData(show: false),
                        spots: spots)
                  ],
                  minX: 0,
                  maxX: 110,
                  maxY: 50,
                  minY: -5,
                ),
                swapAnimationDuration: const Duration(milliseconds: 250),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
