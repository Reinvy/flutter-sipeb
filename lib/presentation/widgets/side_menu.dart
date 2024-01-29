// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sipeb/data/datasources/backup_datasource.dart';
import 'package:sipeb/data/datasources/local_datasource.dart';
import 'package:sipeb/presentation/providers/dashboard_provider.dart';
import 'package:sipeb/presentation/providers/menu_provider.dart';
import 'package:sipeb/presentation/providers/permintaan_provider.dart';

import '../../data/models/screen_model.dart';

class SideMenu extends ConsumerWidget {
  const SideMenu({
    super.key,
    required this.screens,
  });

  final List<ScreenModel> screens;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo_ptpn1.png",
              height: 40,
            ),
            const SizedBox(
              width: 8,
            ),
            const Text("SIP PB-16"),
          ],
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            for (var e in screens)
              Padding(
                padding: const EdgeInsets.all(2),
                child: TextButton(
                  onPressed: () {
                    ref.read(menuProvider.notifier).state = screens.indexOf(e);
                  },
                  child: Text(
                    e.title,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(2),
              child: TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Backup dan Pulihkan Data'),
                        content: const SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text(
                                  'Apakah Anda ingin membuat backup dari data Anda?'),
                              Text(
                                  'Data yang telah dibackup dapat dipulihkan kapan saja.'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text(
                              'Batal',
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Backup'),
                            onPressed: () async {
                              final navigator = Navigator.of(context);
                              final localDS = LocalDataSource();
                              final backupDS = BackupDataSource();
                              final permintaans =
                                  await localDS.getAllPermintaan();
                              await backupDS.backupData(permintaans);
                              navigator.pop();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Backup Berhasil'),
                                    content: const SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                              'Backup data Anda telah berhasil dilakukan.'),
                                          Text(
                                              'Anda dapat memulihkan data ini kapan saja.'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Oke'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          TextButton(
                            child: const Text('Pulihkan'),
                            onPressed: () async {
                              final navigator = Navigator.of(context);
                              final backupDS = BackupDataSource();
                              final localDS = LocalDataSource();
                              final permintaans = await backupDS.pulihkanData();
                              await localDS.pulihkanData(permintaans);
                              ref.invalidate(searchPermintaan);
                              ref.invalidate(daftarItem);
                              ref.invalidate(daftarPermintaan);
                              navigator.pop();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Pemulihan Berhasil'),
                                    content: const SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                              'Pemulihan data Anda telah berhasil dilakukan.'),
                                          Text(
                                              'Data Anda sekarang telah diperbarui dengan data yang dipulihkan.'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Oke'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  "Backup Data",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
