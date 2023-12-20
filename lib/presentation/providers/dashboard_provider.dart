import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sipeb/data/models/item_data_model.dart';

import '../../helpers/database_helper.dart';

final daftarItem = FutureProvider.autoDispose<List<ItemDataModel>>(
  (ref) {
    final localData = DatabaseHelper();
    return localData.getAllItemData();
  },
);
