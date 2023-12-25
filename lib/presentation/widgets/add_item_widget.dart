import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sipeb/data/models/stasiun_model.dart';

import '../../data/models/item_data_model.dart';
import '../../helpers/localization_helper.dart';
import '../providers/add_permintaan_provider.dart';

class AddItemWidget extends ConsumerWidget {
  const AddItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey<FormState>();
    final namaC = TextEditingController();
    final fisikC = TextEditingController();
    final satuanC = TextEditingController();
    StasiunModel? stasiun;
    return Form(
      key: key,
      child: Row(
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
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                      child: DropdownSearch<StasiunModel>(
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
                        selectedItem: stasiun,
                        onChanged: (value) {
                          stasiun = value!;
                        },
                        items: listStasiun,
                        validator: (value) {
                          if (stasiun == null) {
                            return "Silahkan pilih stasiun";
                          }
                          return null;
                        },
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
                          if (key.currentState!.validate()) {
                            ref.read(listItemProvider.notifier).state += [
                              ItemDataModel(
                                id: null,
                                permintaanId: 0,
                                date: LocalizationHelper.reversedFormatTgl(
                                    ref.read(dateCProvider).text),
                                namaBarang: namaC.text,
                                fisik: int.parse(fisikC.text),
                                satuan: satuanC.text,
                                keperluan: stasiun!.name,
                              ),
                            ];
                          }
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
      ),
    );
  }
}
