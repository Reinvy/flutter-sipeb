import 'package:flutter/material.dart';

import '../../data/datasources/local_datasource.dart';
import '../../data/models/karpim_model.dart';

class EditDialog extends StatefulWidget {
  const EditDialog({
    super.key,
    required this.karpim,
  });

  final KarpimModel karpim;

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  final formKey = GlobalKey<FormState>();
  final nameC = TextEditingController();
  final positionC = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameC.text = widget.karpim.name;
    positionC.text = widget.karpim.position;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text("Edit Data Karyawan")),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Nama",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              controller: nameC,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "field tidak boleh kosong";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            if (widget.karpim.position != "Asisten Tata Usaha")
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Jabatan",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: positionC,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "field tidak boleh kosong";
                      }
                      if (value.toLowerCase() ==
                          "Asisten Tata Usaha".toLowerCase()) {
                        return "Jabatan sudah ada";
                      }
                      return null;
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Batal"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                final localDS = LocalDataSource();
                await localDS
                    .updateKarpim(
                      KarpimModel(
                          id: widget.karpim.id,
                          name: nameC.text,
                          position: positionC.text),
                    )
                    .then(
                      (value) => Navigator.pop(context),
                    );
                print(nameC.text);
              }
            },
            child: const Text("Edit Data"),
          ),
        ),
      ],
    );
  }
}
