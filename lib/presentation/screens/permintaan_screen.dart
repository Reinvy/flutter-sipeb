import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sipeb/helpers/localization_helper.dart';
import 'package:sipeb/presentation/providers/permintaan_provider.dart';

import '../widgets/list_permintaan_widget.dart';
import 'add_permintaan_screen.dart';

class PermintaanScreen extends ConsumerWidget {
  const PermintaanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permintaans = ref.watch(searchPermintaan);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Memo Permintaan (PB-16)"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: "Tanggal, Nama Barang, Diminta Oleh",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                ref.read(searchProvider.notifier).state = value;
              },
            ),
          ),
          Expanded(
            child: permintaans.when(
              data: (data) {
                return ListPermintaanWidget(data: data);
              },
              error: (error, stackTrace) {
                return Center(
                  child: Text(error.toString()),
                );
              },
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(right: 20, bottom: 20),
        child: FloatingActionButton(
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddPermintaanScreen(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
