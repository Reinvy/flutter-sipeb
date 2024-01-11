import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sipeb/data/datasources/local_datasource.dart';
import 'package:sipeb/data/models/karpim_model.dart';
import 'package:sipeb/data/models/permintaan_model.dart';
import 'package:sipeb/presentation/providers/add_permintaan_provider.dart';
import 'package:sipeb/presentation/providers/permintaan_provider.dart';

import '../../helpers/localization_helper.dart';
import '../widgets/add_item_widget.dart';
import '../widgets/list_item_widget.dart';
import 'preview_screen.dart';

class AddPermintaanScreen extends ConsumerWidget {
  const AddPermintaanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey<FormState>();
    final listItem = ref.watch(listItemProvider);
    final dateC = ref.watch(dateCProvider.notifier).state;
    final shiftC = ref.watch(shiftCProvider.notifier).state;
    final nameRequestedByC = ref.watch(nameRequestedByCProvider.notifier).state;
    final positionRequestedByC =
        ref.watch(positionRequestedByCProvider.notifier).state;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buat Permintaan"),
      ),
      body: SafeArea(
        child: Form(
          key: key,
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
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 16),
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "field harus di isi!";
                          }
                          return null;
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
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 12),
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
                        selectedItem:
                            shiftC.text.isNotEmpty ? shiftC.text : null,
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
                        "Nama Pemohon",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      DropdownSearch<KarpimModel>(
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            hintText: "Silahkan pilih nama pemohon",
                            border: OutlineInputBorder(),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                        popupProps: const PopupProps.menu(
                          fit: FlexFit.loose,
                        ),
                        itemAsString: (item) =>
                            "${item.name} (${item.position})",
                        onChanged: (value) {
                          nameRequestedByC.text = value!.name;
                          positionRequestedByC.text = value.position;
                        },
                        asyncItems: (text) {
                          final localData = LocalDataSource();
                          return localData.getAllKarpim();
                        },
                        validator: (value) {
                          if (nameRequestedByC.text.isEmpty) {
                            return "Silahkan pilih nama asisten pengolahan";
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
                            item: listItem[i],
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
                  onPressed: () async {
                    if (key.currentState!.validate()) {
                      final navigator = Navigator.of(context);
                      final localDS = LocalDataSource();
                      if (ref.read(listItemProvider).isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                            title: Text(
                              "Data Tidak Valid",
                            ),
                            content: Text(
                              "Data barang masih kosong, silahkan tambah barang terlebih dahulu!",
                            ),
                          ),
                        );
                      } else {
                        final karpim = await localDS.getAllKarpim();
                        final diketahui = karpim.firstWhere((element) =>
                            element.position == "Asisten Tata Usaha");
                        final permintaan = PermintaanModel(
                          id: null,
                          date: LocalizationHelper.reversedFormatTgl(
                            dateC.text,
                          ),
                          knownBy: diketahui.position,
                          nameKnownBy: diketahui.name,
                          shift: shiftC.text,
                          requestBy: positionRequestedByC.text,
                          nameRequestedBy: nameRequestedByC.text,
                          items: listItem,
                        );
                        await localDS.insertPermintaan(permintaan);
                        ref.invalidate(searchPermintaan);
                        navigator.pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => PreviewScreen(
                              permintaan: permintaan,
                            ),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text("Buat Permintaan"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
