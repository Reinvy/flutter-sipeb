import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/permintaan_model.dart';
import '../../helpers/database_helper.dart';
import '../../helpers/localization_helper.dart';
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
  }
}
