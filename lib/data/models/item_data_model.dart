class ItemDataModel {
  int? id;
  int permintaanId;
  DateTime? date;
  final String namaBarang;
  final int fisik;
  final String satuan;
  final String keperluan;

  ItemDataModel({
    required this.id,
    required this.permintaanId,
    required this.date,
    required this.namaBarang,
    required this.fisik,
    required this.satuan,
    required this.keperluan,
  });

  factory ItemDataModel.fromMap(Map<String, dynamic> map) {
    return ItemDataModel(
      id: map['id'],
      permintaanId: map['permintaanId'],
      // date: DateTime.now(),
      date: DateTime.parse(map['date']),
      namaBarang: map['namaBarang'],
      fisik: map['fisik'],
      satuan: map['satuan'],
      keperluan: map['keperluan'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'permintaanId': permintaanId,
      'date': date?.toIso8601String(),
      'namaBarang': namaBarang,
      'fisik': fisik,
      'satuan': satuan,
      'keperluan': keperluan,
    };
  }
}
