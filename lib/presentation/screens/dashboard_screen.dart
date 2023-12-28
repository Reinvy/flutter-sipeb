import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sipeb/presentation/providers/dashboard_provider.dart';
import 'package:sipeb/presentation/widgets/bar_graph_chart.dart';
import 'package:sipeb/presentation/widgets/line_chart_card.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(daftarItem);
    final permintaans = ref.watch(daftarPermintaan);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                "Data PB-16 Dan Permintaan Barang Bulan Ini",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(
                color: Colors.white,
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/approved-document.png",
                        height: 80,
                      ),
                      permintaans.when(
                        data: (data) {
                          final x = data
                              .where(
                                (e) =>
                                    e.date.month == DateTime.now().month &&
                                    e.date.year == DateTime.now().year,
                              )
                              .toList();

                          return Text(
                            x.length.toString(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          );
                        },
                        loading: () => const Text("..."),
                        error: (error, stackTrace) => const Text("?"),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "PB-16",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
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
                      items.when(
                        data: (data) {
                          final x = data
                              .where(
                                (e) =>
                                    e.date!.month == DateTime.now().month &&
                                    e.date!.year == DateTime.now().year,
                              )
                              .toList();

                          return Text(
                            x.length.toString(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          );
                        },
                        loading: () => const Text("..."),
                        error: (error, stackTrace) => const Text("?"),
                      ),
                      Text(
                        "Permintaan Barang",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                "Data Permintaan Barang Stasiun Minggu Ini",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          Card(
            child: SizedBox(
              width: double.infinity,
              child: items.when(
                data: (data) {
                  final thisMonthData = data
                      .where(
                        (e) =>
                            e.date!.month == DateTime.now().month &&
                            e.date!.year == DateTime.now().year,
                      )
                      .toList();
                  return BarGraphCard(
                    thisMonthData: thisMonthData,
                  );
                },
                loading: () => const Text("..."),
                error: (error, stackTrace) => const Text("?"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                "Data PB-16 Tiap Bulan Selama 1 Tahun",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          Card(
            child: SizedBox(
              width: double.infinity,
              child: permintaans.when(
                data: (data) {
                  final thisYearData = data
                      .where(
                        (e) => e.date.year == DateTime.now().year,
                      )
                      .toList();
                  return LineChartCard(
                    thisYearData: thisYearData,
                  );
                },
                loading: () => const Text("..."),
                error: (error, stackTrace) => const Text("?"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
