import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sipeb/constants.dart';
import 'package:sipeb/data/models/permintaan_model.dart';

class BackupDataSource {
  final _dio = Dio();

  Future backupData(List<PermintaanModel> permintaans) async {
    print(permintaans.first);
    final jsonData =
        json.encode(List<dynamic>.from(permintaans.map((e) => e.toJson())));
    final map = {"data": jsonData};
    await _dio.put(
      backupUrl,
      data: map,
    );
  }

  Future<List<PermintaanModel>> pulihkanData() async {
    final response = await _dio.get(backupUrl);
    print(response.data);
    List<PermintaanModel> permintaans = List<PermintaanModel>.from(json
        .decode(response.data["data"])
        .map((x) => PermintaanModel.fromJson(x)));
    print(permintaans);
    return permintaans;
  }
}
