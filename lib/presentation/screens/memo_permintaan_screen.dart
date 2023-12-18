import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sipeb/helpers/database_helper.dart';
import 'package:sipeb/helpers/localization_helper.dart';
import 'package:sipeb/data/models/permintaan_model.dart';
import 'package:sipeb/presentation/providers/permintaan_provider.dart';
import 'package:sipeb/presentation/screens/preview_screen.dart';

import '../../data/models/item_data_model.dart';

class MemoPermintaanScreen extends ConsumerWidget {
  const MemoPermintaanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permintaans = ref.watch(getAllPermintaanProvider);
    final List<PermintaanModel> permintaans1 = [
      PermintaanModel(
        id: null,
        date: DateTime.now(),
        knownBy: "Asisten Tata Usaha",
        nameKnownBy: "Sartim",
        shift: "I",
        requestBy: "Asisten Pengolahan",
        nameRequestedBy: "Septian Burhan",
        items: [
          ItemDataModel(
            id: null,
            permintaanId: 1,
            namaBarang: "Ember",
            fisik: 1,
            satuan: "Bh",
            keperluan: "Stasiun Boiler",
          ),
          ItemDataModel(
            id: null,
            permintaanId: 1,
            namaBarang: "Ember",
            fisik: 1,
            satuan: "Bh",
            keperluan: "Stasiun Boiler",
          ),
          ItemDataModel(
            id: null,
            permintaanId: 1,
            namaBarang: "Ember",
            fisik: 1,
            satuan: "Bh",
            keperluan: "Stasiun Boiler",
          ),
          ItemDataModel(
            id: null,
            permintaanId: 1,
            namaBarang: "Ember",
            fisik: 1,
            satuan: "Bh",
            keperluan: "Stasiun Boiler",
          ),
        ],
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Memo Permintaan (PB-16)"),
      ),
      body: permintaans.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, i) {
              data.sort(
                (a, b) => b.date.compareTo(a.date),
              );
              return GestureDetector(
                onLongPress: () {
                  DatabaseHelper().deletePermintaan(data[i].id!);
                  ref.invalidate(getAllPermintaanProvider);
                },
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PreviewScreen(permintaan: data[i]),
                    ),
                  );
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "SHIFT ${data[i].shift}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "Tanggal Permintaan",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      ": ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        LocalizationHelper.formatTgl(
                                          data[i].date,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "Diketahui oleh",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      ": ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        "${data[i].nameKnownBy} (${data[i].knownBy})",
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "Diminta oleh",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      ": ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        "${data[i].nameRequestedBy} (${data[i].requestBy} Shift ${data[i].shift})",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Daftar Barang Permintaan :",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                for (var e in data[i].items)
                                  Row(
                                    children: [
                                      Text(
                                        "- ${e.namaBarang} ${e.fisik} ${e.satuan}",
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Text(
              error.toString(),
            ),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await DatabaseHelper().insertPermintaan(permintaans1.first);
          ref.invalidate(getAllPermintaanProvider);
        },
      ),
    );
  }
}
