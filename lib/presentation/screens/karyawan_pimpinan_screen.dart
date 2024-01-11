import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sipeb/presentation/providers/karpim_provider.dart';
import 'package:sipeb/presentation/widgets/add_karpim_dialog.dart';
import 'package:sipeb/presentation/widgets/list_karpim_widget.dart';

class KaryawanPimpinanScreen extends ConsumerWidget {
  const KaryawanPimpinanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final karpims = ref.watch(daftarKarpim);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Karyawan Pimpinan"),
      ),
      body: Column(
        children: [
          Expanded(
            child: karpims.when(
              data: (data) {
                return ListKarPimWidget(data: data);
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
            showDialog(
              context: context,
              builder: (context) {
                return const AddKarpimDialog();
              },
            ).then(
              (value) => ref.invalidate(daftarKarpim),
            );
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const Addkarpimscreen(),
            //   ),
            // );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
