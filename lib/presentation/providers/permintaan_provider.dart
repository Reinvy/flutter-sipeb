import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sipeb/data/datasources/local_datasource.dart';
import 'package:sipeb/data/models/permintaan_model.dart';
import 'package:sipeb/helpers/localization_helper.dart';

final searchPermintaan = FutureProvider.autoDispose<List<PermintaanModel>>(
  (ref) async {
    final search = ref.watch(searchProvider);
    final localData = LocalDataSource();
    final permintaans = await localData.getAllPermintaan();
    print(search);
    if (search.isNotEmpty) {
      print("object");
      final searched = permintaans
          .where((element) =>
              element.nameRequestedBy
                  .toLowerCase()
                  .contains(search.toLowerCase()) ||
              LocalizationHelper.formatTgl(element.date)
                  .toLowerCase()
                  .contains(search.toLowerCase()) ||
              element.items.any(
                (e) =>
                    e.keperluan.toLowerCase().contains(search.toLowerCase()) ||
                    e.namaBarang.toLowerCase().contains(search.toLowerCase()),
              ))
          .toList();
      return searched;
    } else {
      print("objectw");
      return permintaans;
    }
  },
);

final searchProvider = StateProvider.autoDispose<String>((ref) => "");
