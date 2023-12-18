import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../models/bar_graph_model.dart';
import '../../models/graph_model.dart';
import 'custom_card.dart';

class BarGraphCard extends StatelessWidget {
  BarGraphCard({super.key});

  final List<BarGraphModel> data = [
    BarGraphModel(
        lable: "PB 16",
        color: const Color.fromARGB(248, 43, 87, 245),
        graph: [
          GraphModel(x: 0, y: 8),
          GraphModel(x: 1, y: 10),
          GraphModel(x: 2, y: 7),
          GraphModel(x: 3, y: 4),
          GraphModel(x: 4, y: 4),
          GraphModel(x: 5, y: 6),
          GraphModel(x: 6, y: 6),
        ]),
    BarGraphModel(
        lable: "AU 58",
        color: const Color.fromARGB(255, 241, 179, 117),
        graph: [
          GraphModel(x: 0, y: 8),
          GraphModel(x: 1, y: 10),
          GraphModel(x: 2, y: 9),
          GraphModel(x: 3, y: 7),
          GraphModel(x: 4, y: 6),
          GraphModel(x: 5, y: 5),
          GraphModel(x: 6, y: 5),
        ]),
    BarGraphModel(
        lable: "Reservasi",
        color: const Color.fromARGB(255, 69, 175, 228),
        graph: [
          GraphModel(x: 0, y: 7),
          GraphModel(x: 1, y: 10),
          GraphModel(x: 2, y: 7),
          GraphModel(x: 3, y: 4),
          GraphModel(x: 4, y: 4),
          GraphModel(x: 5, y: 10),
          GraphModel(x: 6, y: 10),
        ]),
  ];

  final lable = ['S', 'S', 'R', 'K', 'J', 'S', 'M'];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: data.length,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 15,
          mainAxisSpacing: 12.0,
          childAspectRatio: 5 / 4),
      itemBuilder: (context, i) {
        return CustomCard(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    data[i].lable,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: BarChart(
                    BarChartData(
                      barGroups: _chartGroups(
                          points: data[i].graph, color: data[i].color),
                      borderData: FlBorderData(border: const Border()),
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                lable[value.toInt()],
                                style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                              ),
                            );
                          },
                        )),
                        leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                      ),
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }

  List<BarChartGroupData> _chartGroups(
      {required List<GraphModel> points, required Color color}) {
    return points
        .map((point) => BarChartGroupData(x: point.x.toInt(), barRods: [
              BarChartRodData(
                toY: point.y,
                width: 12,
                color: color.withOpacity(point.y.toInt() > 4 ? 1 : 0.4),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(3.0),
                  topRight: Radius.circular(3.0),
                ),
              )
            ]))
        .toList();
  }
}