import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sipeb/data/datasources/local_datasource.dart';
import 'package:sipeb/data/models/item_data_model.dart';
import 'package:sipeb/data/models/permintaan_model.dart';

final daftarItem = FutureProvider.autoDispose<List<ItemDataModel>>(
  (ref) {
    final localData = LocalDataSource();
    return localData.getAllItemData();
  },
);
final daftarPermintaan = FutureProvider.autoDispose<List<PermintaanModel>>(
  (ref) {
    final localData = LocalDataSource();
    return localData.getAllPermintaan();
  },
);
