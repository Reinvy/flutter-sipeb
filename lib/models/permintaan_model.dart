import 'package:sipeb/models/item_data_model.dart';

class PermintaanModel {
  final DateTime date;
  final String knownBy;
  final String nameKnownBy;
  final String shift;
  final String requestBy;
  final String nameRequestedBy;
  final List<ItemDataModel> items;

  PermintaanModel({
    required this.date,
    required this.knownBy,
    required this.nameKnownBy,
    required this.shift,
    required this.requestBy,
    required this.nameRequestedBy,
    required this.items,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'known_by': knownBy,
      'name_known_by': nameKnownBy,
      'shift': shift,
      'request_by': requestBy,
      'name_requested_by': nameRequestedBy,
    };
  }
}
