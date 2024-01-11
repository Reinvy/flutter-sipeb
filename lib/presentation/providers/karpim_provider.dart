import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sipeb/data/models/karpim_model.dart';

import '../../data/datasources/local_datasource.dart';

final daftarKarpim = FutureProvider.autoDispose<List<KarpimModel>>(
  (ref) {
    final localData = LocalDataSource();
    return localData.getAllKarpim();
  },
);
