import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/item_data_model.dart';
import '../providers/add_permintaan_provider.dart';

class AddItemWidget extends ConsumerWidget {
  const AddItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final namaC = TextEditingController();
    final fisikC = TextEditingController();
    final satuanC = TextEditingController();
    final stasiunC = TextEditingController();
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Nama Barang",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: namaC,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Fisik",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: fisikC,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Satuan",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: satuanC,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Nama Stasiun",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: stasiunC,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(48, 48),
                      ),
                      onPressed: () {
                        ref.read(listItemProvider.notifier).state += [
                          ItemDataModel(
                            id: null,
                            permintaanId: 0,
                            date: null,
                            namaBarang: namaC.text,
                            fisik: int.parse(fisikC.text),
                            satuan: satuanC.text,
                            keperluan: stasiunC.text,
                          ),
                        ];
                        namaC.clear();
                        fisikC.clear();
                        satuanC.clear();
                        stasiunC.clear();
                      },
                      child: const Icon(Icons.add),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
