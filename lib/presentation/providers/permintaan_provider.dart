import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sipeb/data/models/permintaan_model.dart';
import 'package:sipeb/helpers/database_helper.dart';

final getAllPermintaanProvider =
    FutureProvider.autoDispose<List<PermintaanModel>>(
  (ref) {
    final localData = DatabaseHelper();
    return localData.getAllPermintaan();
  },
);
