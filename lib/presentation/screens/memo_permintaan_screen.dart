import 'package:flutter/material.dart';
import 'package:sipeb/helpers/localization_helper.dart';
import 'package:sipeb/models/permintaan_model.dart';
import 'package:sipeb/presentation/screens/preview_screen.dart';

import '../../models/item_data_model.dart';

class MemoPermintaanScreen extends StatefulWidget {
  const MemoPermintaanScreen({super.key});

  @override
  State<MemoPermintaanScreen> createState() => _MemoPermintaanScreenState();
}

class _MemoPermintaanScreenState extends State<MemoPermintaanScreen> {
  @override
  Widget build(BuildContext context) {
    final List<PermintaanModel> permintaans = [
      PermintaanModel(
        date: DateTime.now(),
        knownBy: "Asisten Tata Usaha",
        nameKnownBy: "Sartim",
        shift: "I",
        requestBy: "Asisten Pengolahan",
        nameRequestedBy: "Septian Burhan",
        items: [
          ItemDataModel("Ember", 1, "Bh", "Stasiun Boiler"),
          ItemDataModel("Sepatu", 2, "Bh", "Stasiun Boiler"),
          ItemDataModel("Helm", 5, "Bh", "Stasiun Boiler"),
          ItemDataModel("Sarung tangan", 1, "Bh", "Stasiun Boiler"),
          ItemDataModel("Masker", 4, "Bh", "Stasiun Boiler"),
          ItemDataModel("Masker", 4, "Bh", "Stasiun Boiler"),
          ItemDataModel("Masker", 4, "Bh", "Stasiun Boiler"),
        ],
      ),
      PermintaanModel(
        date: DateTime.now().add(
          const Duration(days: 12),
        ),
        knownBy: "Asisten Tata Usaha",
        nameKnownBy: "Sartim",
        shift: "I",
        requestBy: "Asisten Pengolahan",
        nameRequestedBy: "Septian Burhan",
        items: [
          ItemDataModel("Ember", 1, "Bh", "Stasiun Boiler"),
          ItemDataModel("Sepatu", 2, "Bh", "Stasiun Boiler"),
          ItemDataModel("Helm", 5, "Bh", "Stasiun Boiler"),
          ItemDataModel("Sarung tangan", 1, "Bh", "Stasiun Boiler"),
          ItemDataModel("Masker", 4, "Bh", "Stasiun Boiler"),
          ItemDataModel("Masker", 4, "Bh", "Stasiun Boiler"),
          ItemDataModel("Masker", 4, "Bh", "Stasiun Boiler"),
        ],
      ),
      PermintaanModel(
        date: DateTime.now().add(
          const Duration(days: 30),
        ),
        knownBy: "Asisten Tata Usaha",
        nameKnownBy: "Sartim",
        shift: "I",
        requestBy: "Asisten Pengolahan",
        nameRequestedBy: "Septian Burhan",
        items: [
          ItemDataModel("Ember", 1, "Bh", "Stasiun Boiler"),
          ItemDataModel("Sepatu", 2, "Bh", "Stasiun Boiler"),
          ItemDataModel("Helm", 5, "Bh", "Stasiun Boiler"),
          ItemDataModel("Sarung tangan", 1, "Bh", "Stasiun Boiler"),
          ItemDataModel("Masker", 4, "Bh", "Stasiun Boiler"),
          ItemDataModel("Masker", 4, "Bh", "Stasiun Boiler"),
          ItemDataModel("Masker", 4, "Bh", "Stasiun Boiler"),
        ],
      ),
      PermintaanModel(
        date: DateTime.now().add(
          const Duration(days: 30),
        ),
        knownBy: "Asisten Tata Usaha",
        nameKnownBy: "Sartim",
        shift: "I",
        requestBy: "Asisten Pengolahan",
        nameRequestedBy: "Septian Burhan",
        items: [
          ItemDataModel("Ember", 1, "Bh", "Stasiun Boiler"),
          ItemDataModel("Sepatu", 2, "Bh", "Stasiun Boiler"),
          ItemDataModel("Helm", 5, "Bh", "Stasiun Boiler"),
          ItemDataModel("Sarung tangan", 1, "Bh", "Stasiun Boiler"),
          ItemDataModel("Masker", 4, "Bh", "Stasiun Boiler"),
          ItemDataModel("Masker", 4, "Bh", "Stasiun Boiler"),
          ItemDataModel("Masker", 4, "Bh", "Stasiun Boiler"),
        ],
      ),
      PermintaanModel(
        date: DateTime.now().add(
          const Duration(days: 30),
        ),
        knownBy: "Asisten Tata Usaha",
        nameKnownBy: "Sartim",
        shift: "I",
        requestBy: "Asisten Pengolahan",
        nameRequestedBy: "Septian Burhan",
        items: [
          ItemDataModel("Ember", 1, "Bh", "Stasiun Boiler"),
          ItemDataModel("Sepatu", 2, "Bh", "Stasiun Boiler"),
          ItemDataModel("Helm", 5, "Bh", "Stasiun Boiler"),
          ItemDataModel("Sarung tangan", 1, "Bh", "Stasiun Boiler"),
          ItemDataModel("Masker", 4, "Bh", "Stasiun Boiler"),
          ItemDataModel("Masker", 4, "Bh", "Stasiun Boiler"),
          ItemDataModel("Masker", 4, "Bh", "Stasiun Boiler"),
        ],
      ),
      PermintaanModel(
        date: DateTime.now().add(
          const Duration(days: 20),
        ),
        knownBy: "Asisten Tata Usaha",
        nameKnownBy: "Sartim",
        shift: "I",
        requestBy: "Asisten Pengolahan",
        nameRequestedBy: "Septian Burhan",
        items: [
          ItemDataModel("Ember", 1, "Bh", "Stasiun Boiler"),
          ItemDataModel("Sepatu", 2, "Bh", "Stasiun Boiler"),
          ItemDataModel("Helm", 5, "Bh", "Stasiun Boiler"),
          ItemDataModel("Sarung tangan", 1, "Bh",
              "Stasiun Boiler dan Stasiun Sterilisasi"),
          ItemDataModel("Masker", 4, "Bh", "Stasiun Boiler"),
          ItemDataModel("Masker", 4, "Bh", "Stasiun Boiler"),
          ItemDataModel("Masker", 4, "Bh", "Stasiun Boiler"),
        ],
      ),
      PermintaanModel(
        date: DateTime.now().add(
          const Duration(days: 30),
        ),
        knownBy: "Asisten Tata Usaha",
        nameKnownBy: "Sartim",
        shift: "I",
        requestBy: "Asisten Pengolahan",
        nameRequestedBy: "Septian Burhan",
        items: [
          ItemDataModel("Ember", 1, "Bh", "Stasiun Boiler"),
          ItemDataModel("Sepatu", 2, "Bh", "Stasiun Boiler"),
          ItemDataModel("Helm", 5, "Bh", "Stasiun Boiler"),
          ItemDataModel("Sarung tangan", 1, "Bh", "Stasiun Boiler"),
          ItemDataModel("Masker", 4, "Bh", "Stasiun Boiler"),
          ItemDataModel("Masker", 4, "Bh", "Stasiun Boiler"),
          ItemDataModel("Masker", 4, "Bh", "Stasiun Boiler"),
        ],
      ),
      PermintaanModel(
        date: DateTime.now().add(
          const Duration(days: 30),
        ),
        knownBy: "Asisten Tata Usaha",
        nameKnownBy: "Sartim",
        shift: "I",
        requestBy: "Asisten Pengolahan",
        nameRequestedBy: "Septian Burhan",
        items: [
          ItemDataModel("Ember", 1, "Bh", "Stasiun Boiler"),
          ItemDataModel("Sepatu", 2, "Bh", "Stasiun Boiler"),
          ItemDataModel("Helm", 5, "Bh", "Stasiun Boiler"),
          ItemDataModel("Sarung tangan", 1, "Bh", "Stasiun Boiler"),
          ItemDataModel("Masker", 4, "Bh", "Stasiun Boiler"),
          ItemDataModel("Masker", 4, "Bh", "Stasiun Boiler"),
          ItemDataModel("Masker", 4, "Bh", "Stasiun Boiler"),
        ],
      ),
    ];
    return Scaffold(
        appBar: AppBar(
          title: const Text("Memo Permintaan (PB-16)"),
        ),
        body: ListView.builder(
          itemCount: permintaans.length,
          itemBuilder: (context, i) {
            permintaans.sort(
              (a, b) => b.date.compareTo(a.date),
            );
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PreviewScreen(permintaan: permintaans[i]),
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
                                "SHIFT ${permintaans[i].shift}",
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
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      LocalizationHelper.formatTgl(
                                        permintaans[i].date,
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
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      "${permintaans[i].nameKnownBy} (${permintaans[i].knownBy})",
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
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      "${permintaans[i].nameRequestedBy} (${permintaans[i].requestBy} Shift ${permintaans[i].shift})",
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
                              for (var e in permintaans[i].items)
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
        ));
  }
}
