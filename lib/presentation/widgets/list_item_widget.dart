import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/item_data_model.dart';
import '../providers/add_permintaan_provider.dart';

class ListItemWidget extends ConsumerStatefulWidget {
  const ListItemWidget({
    super.key,
    required this.index,
    required this.nama,
    required this.fisik,
    required this.satuan,
    required this.stasiun,
  });

  final int index;
  final String nama;
  final int fisik;
  final String satuan;
  final String stasiun;

  @override
  ConsumerState<ListItemWidget> createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends ConsumerState<ListItemWidget> {
  final namaC = TextEditingController();
  final fisikC = TextEditingController();
  final satuanC = TextEditingController();
  final stasiunC = TextEditingController();
  @override
  void initState() {
    namaC.text = widget.nama;
    fisikC.text = widget.fisik.toString();
    satuanC.text = widget.satuan;
    stasiunC.text = widget.stasiun;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                onChanged: (value) {
                  setState(() {});
                },
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
                onChanged: (value) {
                  setState(() {});
                },
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
                onChanged: (value) {
                  setState(() {});
                },
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
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if (namaC.text != widget.nama ||
                      int.tryParse(fisikC.text) != widget.fisik ||
                      satuanC.text != widget.satuan ||
                      stasiunC.text != widget.stasiun)
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
                              namaBarang: "namaBarang",
                              fisik: 1,
                              satuan: "satuan",
                              keperluan: "keperluan",
                            ),
                          ];
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
                        print(widget.index);

                        ref
                            .watch(listItemProvider.notifier)
                            .state
                            .removeAt(widget.index);
                        setState(() {});
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
