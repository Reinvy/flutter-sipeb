import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sipeb/data/models/item_data_model.dart';

final listItemProvider = StateProvider<List<ItemDataModel>>(
  (ref) {
    return List.empty();
  },
);
