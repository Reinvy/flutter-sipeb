import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sipeb/data/datasources/local_datasource.dart';
import 'package:sipeb/data/models/karpim_model.dart';
import 'package:sipeb/presentation/providers/karpim_provider.dart';

import 'edit_dialog.dart';

class ListKarPimWidget extends ConsumerWidget {
  const ListKarPimWidget({super.key, required this.data});

  final List<KarpimModel> data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, i) {
        return Card(
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                "Nama",
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
                                data[i].name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
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
                                "Jabatan",
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
                                data[i].position,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return EditDialog(karpim: data[i]);
                          },
                        ).then(
                          (value) => ref.invalidate(daftarKarpim),
                        );
                      },
                      child: const Text("Edit")),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: data[i].position == "Asisten Tata Usaha"
                        ? null
                        : () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Center(
                                      child: Text(
                                    "Hapus Karyawan",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  )),
                                  content: const Text(
                                    "Apakah anda ingin menghapus data karyawan?",
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),
                                      onPressed: () async {
                                        final navigator = Navigator.of(context);
                                        final localDS = LocalDataSource();
                                        await localDS.deleteKarpim(data[i].id!);
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
                            ).then(
                              (value) => ref.invalidate(daftarKarpim),
                            );
                          },
                    child: const Text("Hapus"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
