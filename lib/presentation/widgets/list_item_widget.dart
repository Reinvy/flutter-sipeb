import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sipeb/data/models/item_data_model.dart';

import '../providers/add_permintaan_provider.dart';
import 'edit_item_widget.dart';

class ListItemWidget extends ConsumerWidget {
  const ListItemWidget({
    super.key,
    required this.index,
    required this.item,
    // required this.nama,
    // required this.fisik,
    // required this.satuan,
    // required this.stasiun,
  });

  final int index;
  final ItemDataModel item;
  // final String nama;
  // final int fisik;
  // final String satuan;
  // final String stasiun;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final namaC = TextEditingController(text: item.namaBarang);
    final fisikC = TextEditingController(text: item.fisik.toString());
    final satuanC = TextEditingController(text: item.satuan);
    final stasiunC = TextEditingController(text: item.keperluan);

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
                readOnly: true,
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
                readOnly: true,
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
                readOnly: true,
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
                      readOnly: true,
                      controller: stasiunC,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(48, 48),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return EditItemWidget(
                              index: index,
                              item: item,
                            );
                          },
                        );
                      },
                      child: const Icon(Icons.edit),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(48, 48),
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        final data = ref.read(listItemProvider);
                        print(data.length);
                        data.removeAt(index);
                        print(data.length);
                        ref.read(listItemProvider.notifier).state =
                            List.from(data);
                      },
                      child: const Icon(Icons.delete),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
