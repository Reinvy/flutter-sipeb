import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sipeb/data/models/item_data_model.dart';
import 'package:sipeb/helpers/localization_helper.dart';

import '../../data/models/stasiun_model.dart';
import '../providers/add_permintaan_provider.dart';

class EditItemWidget extends ConsumerWidget {
  const EditItemWidget({
    super.key,
    required this.index,
    required this.item,
    // this.itemId,
    // this.permintaanId,
    // required this.nama,
    // required this.fisik,
    // required this.satuan,
    // required this.stasiun,
  });

  final int index;
  final ItemDataModel item;
  // final int? itemId;
  // final int? permintaanId;
  // final String nama;
  // final int fisik;
  // final String satuan;
  // final String stasiun;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey<FormState>();
    final namaC = TextEditingController(text: item.namaBarang);
    final fisikC = TextEditingController(text: item.fisik.toString());
    final satuanC = TextEditingController(text: item.satuan);
    StasiunModel stasiunC = StasiunModel(name: item.keperluan);
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: key,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "EDIT ITEM",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
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
                            hintText: "Isi nama barang",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "nama barang harus di isi!";
                            }
                            return null;
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
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Isi fisik",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "fisik harus di isi!";
                            }
                            return null;
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
                            hintText: "Isi satuan",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "satuan harus di isi!";
                            }
                            return null;
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
                      mainAxisSize: MainAxisSize.min,
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
                        DropdownSearch<StasiunModel>(
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              hintText: "Silahkan pilih stasiun",
                              border: OutlineInputBorder(),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 12),
                            ),
                          ),
                          popupProps: const PopupProps.menu(
                            // showSelectedItems: true,
                            fit: FlexFit.loose,
                          ),
                          itemAsString: (item) => item.name,
                          selectedItem: stasiunC,
                          onChanged: (value) {
                            stasiunC = value!;
                          },
                          items: listStasiun,
                          validator: (value) {
                            if (stasiunC.name.isEmpty) {
                              return "Silahkan pilih stasiun";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(80, 40),
                    ),
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        final data = ref.read(listItemProvider);
                        data[index] = ItemDataModel(
                          id: item.id,
                          permintaanId: item.permintaanId,
                          date: LocalizationHelper.reversedFormatTgl(
                              ref.read(dateCProvider).text),
                          namaBarang: namaC.text,
                          fisik: int.parse(fisikC.text),
                          satuan: satuanC.text,
                          keperluan: stasiunC.name,
                        );
                        ref.read(listItemProvider.notifier).state =
                            List.from(data);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("EDIT"),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(80, 40),
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("BATAL"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
