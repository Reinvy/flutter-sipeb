import 'package:sipeb/data/models/item_data_model.dart';

class PermintaanModel {
  int? id;
  DateTime date;
  String knownBy;
  String nameKnownBy;
  String shift;
  String requestBy;
  String nameRequestedBy;
  List<ItemDataModel> items;

  PermintaanModel({
    required this.id,
    required this.date,
    required this.knownBy,
    required this.nameKnownBy,
    required this.shift,
    required this.requestBy,
    required this.nameRequestedBy,
    required this.items,
  });

  factory PermintaanModel.fromMap(Map<String, dynamic> map) {
    return PermintaanModel(
        id: map['id'],
        date: DateTime.parse(map['date']),
        knownBy: map['knownBy'],
        nameKnownBy: map['nameKnownBy'],
        shift: map['shift'],
        requestBy: map['requestBy'],
        nameRequestedBy: map['nameRequestedBy'],
        items: []);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'knownBy': knownBy,
      'nameKnownBy': nameKnownBy,
      'shift': shift,
      'requestBy': requestBy,
      'nameRequestedBy': nameRequestedBy,
    };
  }
}
