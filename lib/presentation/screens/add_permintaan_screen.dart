import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sipeb/data/models/permintaan_model.dart';
import 'package:sipeb/helpers/database_helper.dart';
import 'package:sipeb/presentation/providers/add_permintaan_provider.dart';
import 'package:sipeb/presentation/providers/permintaan_provider.dart';

import '../../helpers/localization_helper.dart';
import '../widgets/add_item_widget.dart';
import '../widgets/list_item_widget.dart';

class AddPermintaanScreen extends ConsumerWidget {
  const AddPermintaanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listItem = ref.watch(listItemProvider);
    final dateC = TextEditingController(
      text: LocalizationHelper.formatTgl(
        DateTime.now(),
      ),
    );
    final shiftC = TextEditingController();
    final nameRequestedByC = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buat Permintaan"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Tanggal Permintaan",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: dateC,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
                        hintText: "Tanggal Lahir",
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        border: OutlineInputBorder(),
                      ),
                      onTap: () async {
                        final datePicked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        if (datePicked != null) {
                          dateC.text = LocalizationHelper.formatTgl(
                            datePicked,
                          );

                          print(datePicked);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Shift",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    DropdownSearch<String>(
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          hintText: "Silahkan pilih shift",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                      popupProps: const PopupProps.menu(
                        showSelectedItems: true,
                        fit: FlexFit.loose,
                      ),
                      onChanged: (value) {
                        shiftC.text = value!;
                      },
                      items: const ["I", "II"],
                      validator: (value) {
                        if (shiftC.text.isEmpty) {
                          return "Silahkan pilih shift";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Nama Asisten Pengolahan",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    DropdownSearch<String>(
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          hintText: "Silahkan pilih nama asisten pengolahan",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                      popupProps: const PopupProps.menu(
                        showSelectedItems: true,
                        fit: FlexFit.loose,
                      ),
                      onChanged: (value) {
                        nameRequestedByC.text = value!;
                      },
                      items: const ["RizQy Aulia", "Septian Burhan"],
                      validator: (value) {
                        if (nameRequestedByC.text.isEmpty) {
                          return "Silahkan pilih shift";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    const AddItemWidget(),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return ListItemWidget(
                          index: i,
                          nama: listItem[i].namaBarang,
                          fisik: listItem[i].fisik,
                          satuan: listItem[i].satuan,
                          stasiun: listItem[i].keperluan,
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 12,
                      ),
                      itemCount: listItem.length,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 40),
                ),
                onPressed: () {
                  DatabaseHelper().insertPermintaan(
                    PermintaanModel(
                      id: null,
                      date: LocalizationHelper.reversedFormatTgl(dateC.text),
                      knownBy: "Asisten Tata Usaha",
                      nameKnownBy: "T. Zulfikar",
                      shift: shiftC.text,
                      requestBy: "Asisten Pengolahan",
                      nameRequestedBy: nameRequestedByC.text,
                      items: listItem,
                    ),
                  );
                  ref.invalidate(getAllPermintaanProvider);
                },
                child: Text("Buat Permintaan"),
              ),
            )
          ],
        ),
      ),
    );
  }
}