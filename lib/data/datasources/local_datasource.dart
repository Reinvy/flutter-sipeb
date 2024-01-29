// ignore_for_file: depend_on_referenced_packages

import 'dart:io' as io;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sipeb/data/models/karpim_model.dart';
import 'package:sipeb/helpers/database_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../models/item_data_model.dart';
import '../models/permintaan_model.dart';

class LocalDataSource {
  final databaseHelper = DatabaseHelper();

  pulihkanData(List<PermintaanModel> permintaans) async {
    sqfliteFfiInit();
    var databaseFactory = databaseFactoryFfi;
    final io.Directory databasesPath = await getApplicationDocumentsDirectory();

    String path = p.join(databasesPath.path, "databases", "sip.db");
    await databaseFactory.deleteDatabase(path);
    for (var element in permintaans) {
      await insertPermintaan(element);
    }
  }

  Future<int> insertPermintaan(PermintaanModel permintaan) async {
    Database db = await databaseHelper.initDatabase();
    int id = await db.insert('permintaan', permintaan.toMap());
    for (ItemDataModel item in permintaan.items) {
      item.permintaanId = id;
      item.date = permintaan.date;

      await db.insert('itemData', item.toMap());
    }
    return id;
  }

  Future<List<PermintaanModel>> getAllPermintaan() async {
    try {
      Database db = await databaseHelper.initDatabase();

      List<Map<String, dynamic>> permintaanMaps = await db.query('permintaan');
      List<PermintaanModel> permintaans = permintaanMaps.map((permintaanMap) {
        return PermintaanModel.fromMap(permintaanMap);
      }).toList();

      for (PermintaanModel permintaan in permintaans) {
        List<Map<String, dynamic>> itemMaps = await db.query('itemData',
            where: 'permintaanId = ?', whereArgs: [permintaan.id]);

        print(itemMaps);
        List<ItemDataModel> items = itemMaps.map((itemMap) {
          return ItemDataModel.fromMap(itemMap);
        }).toList();

        permintaan.items = items;
      }

      return permintaans;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<ItemDataModel>> getAllItemData() async {
    try {
      Database db = await databaseHelper.initDatabase();
      List<Map<String, dynamic>> itemMaps = await db.query('itemData');
      List<ItemDataModel> items = itemMaps.map((itemMap) {
        return ItemDataModel.fromMap(itemMap);
      }).toList();

      return items;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> updatePermintaan(PermintaanModel permintaan) async {
    Database db = await databaseHelper.initDatabase();
    await db.update('permintaan', permintaan.toMap(),
        where: 'id = ?', whereArgs: [permintaan.id]);

    List<Map<String, dynamic>> itemMaps = await db.query('itemData',
        where: 'permintaanId = ?', whereArgs: [permintaan.id]);
    List<ItemDataModel> items = itemMaps.map((itemMap) {
      return ItemDataModel.fromMap(itemMap);
    }).toList();

    for (ItemDataModel item in permintaan.items) {
      item.date = permintaan.date;
      if (item.id == null) {
        print("tambah");
        print(item.namaBarang);
        item.permintaanId = permintaan.id!;
        await db.insert('itemData', item.toMap());
      } else {
        print("update");
        print(item.namaBarang);
        await db.update('itemData', item.toMap(),
            where: 'id = ?', whereArgs: [item.id]);
      }
    }

    for (var element in items) {
      if (permintaan.items.any((e) => e.id == element.id)) {
        continue;
      }
      print("hapus");
      print(element.namaBarang);
      await db.delete('itemData', where: 'id = ?', whereArgs: [element.id]);
    }
  }

  Future<void> deletePermintaan(int id) async {
    Database db = await databaseHelper.initDatabase();
    await db.delete('permintaan', where: 'id = ?', whereArgs: [id]);

    // Delete items
    List<Map<String, dynamic>> itemMaps =
        await db.query('itemData', where: 'permintaanId = ?', whereArgs: [id]);
    List<ItemDataModel> items = itemMaps.map((itemMap) {
      return ItemDataModel.fromMap(itemMap);
    }).toList();

    for (ItemDataModel item in items) {
      await db.delete('itemData', where: 'id = ?', whereArgs: [item.id]);
    }
  }

  Future<List<KarpimModel>> getAllKarpim() async {
    try {
      Database db = await databaseHelper.initDatabase();
      List<Map<String, dynamic>> karpimMaps = await db.query('karpim');
      List<KarpimModel> karpims = karpimMaps.map((karpimMap) {
        return KarpimModel.fromMap(karpimMap);
      }).toList();
      return karpims;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> updateKarpim(KarpimModel karpim) async {
    Database db = await databaseHelper.initDatabase();
    await db.update('karpim', karpim.toMap(),
        where: 'id = ?', whereArgs: [karpim.id]);
  }

  Future<int> insertKarpim(KarpimModel karpim) async {
    Database db = await databaseHelper.initDatabase();

    return await db.insert(
      "karpim",
      {"name": karpim.name, "position": karpim.position},
    );
  }

  Future<void> deleteKarpim(int id) async {
    Database db = await databaseHelper.initDatabase();
    await db.delete('karpim', where: 'id = ?', whereArgs: [id]);
  }
}
