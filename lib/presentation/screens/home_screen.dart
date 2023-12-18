import 'package:flutter/material.dart';
import 'package:sipeb/presentation/widgets/bar_graph_chart.dart';
import 'package:sipeb/presentation/widgets/line_chart_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/money-document.png",
                        height: 80,
                      ),
                      Text(
                        "200",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Permintaan Barang",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/money-document.png",
                        height: 80,
                      ),
                      Text(
                        "8",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Rekening",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/money-document.png",
                        height: 80,
                      ),
                      Text(
                        "8",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Rekening",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Card(
            child: SizedBox(
              width: double.infinity,
              child: LineChartCard(),
            ),
          ),
          Card(
            child: SizedBox(
              width: double.infinity,
              child: BarGraphCard(),
            ),
          ),
        ],
      ),
    );
  }
}
