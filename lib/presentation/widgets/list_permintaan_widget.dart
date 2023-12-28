import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sipeb/presentation/screens/edit_permintaan_screen.dart';

import '../../data/datasources/local_datasource.dart';
import '../../data/models/permintaan_model.dart';
import '../../helpers/localization_helper.dart';
import '../providers/add_permintaan_provider.dart';
import '../providers/permintaan_provider.dart';
import '../screens/preview_screen.dart';

class ListPermintaanWidget extends ConsumerWidget {
  const ListPermintaanWidget({
    super.key,
    required this.data,
  });

  final List<PermintaanModel> data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, i) {
        data.sort(
          (a, b) => b.date.compareTo(a.date),
        );

        return GestureDetector(
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
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                ": ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
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
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                ": ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
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
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                ": ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
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
                                  "- ${e.namaBarang} ${e.fisik} ${e.satuan} untuk stasiun ${e.keperluan}",
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          ref.watch(dateCProvider.notifier).state.text =
                              LocalizationHelper.formatTgl(
                            data[i].date,
                          );
                          ref.watch(shiftCProvider.notifier).state.text =
                              data[i].shift;
                          ref
                              .watch(nameRequestedByCProvider.notifier)
                              .state
                              .text = data[i].nameRequestedBy;
                          ref.watch(listItemProvider.notifier).state =
                              data[i].items;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditPermintaanScreen(
                                  permintaanId: data[i].id!),
                            ),
                          ).then((value) {
                            ref.invalidate(dateCProvider);
                            ref.invalidate(shiftCProvider);
                            ref.invalidate(nameRequestedByCProvider);
                            ref.invalidate(listItemProvider);
                            ref.invalidate(searchPermintaan);
                          });
                        },
                        child: Text("Edit")),
                    SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Center(
                                  child: Text(
                                "Hapus Permintaan",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              )),
                              content: const Text(
                                  "Apakah anda ingin menghapus permintaan?"),
                              actions: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red),
                                  onPressed: () async {
                                    final navigator = Navigator.of(context);
                                    final localDS = LocalDataSource();
                                    await localDS.deletePermintaan(data[i].id!);
                                    ref.invalidate(searchPermintaan);
                                    navigator.pop();
                                  },
                                  child: const Text("Hapus"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    final navigator = Navigator.of(context);
                                    navigator.pop();
                                  },
                                  child: const Text("Batal"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text("Hapus"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
