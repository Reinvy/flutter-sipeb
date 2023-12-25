import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sipeb/data/models/item_data_model.dart';

import '../../helpers/localization_helper.dart';

final listItemProvider = StateProvider.autoDispose<List<ItemDataModel>>(
  (ref) {
    return List.empty();
  },
);

final dateCProvider = StateProvider.autoDispose<TextEditingController>((ref) {
  return TextEditingController(
    text: LocalizationHelper.formatTgl(
      DateTime.now(),
    ),
  );
});
final shiftCProvider = StateProvider.autoDispose<TextEditingController>((ref) {
  return TextEditingController();
});
final nameRequestedByCProvider =
    StateProvider.autoDispose<TextEditingController>((ref) {
  return TextEditingController();
});
