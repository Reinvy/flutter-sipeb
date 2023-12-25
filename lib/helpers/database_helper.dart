import 'dart:io' as io;
import 'package:path/path.dart' as p;

import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../data/models/item_data_model.dart';
import '../data/models/permintaan_model.dart';

class DatabaseHelper {
  Future<Database> initDatabase() async {
    sqfliteFfiInit();
    var databaseFactory = databaseFactoryFfi;
    final io.Directory databasesPath = await getApplicationDocumentsDirectory();

    String path = p.join(databasesPath.path, "databases", "sip.db");
    print(path);

    var initDb = await databaseFactory.openDatabase(
      path,
    );
    var res = await initDb.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
        ["permintaan"]);
    if (res.isEmpty) {
      print(res.toString());
      await _createDb(initDb, 1);
    }

    return initDb;
  }

  Future<void> _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE permintaan('
        'id INTEGER PRIMARY KEY,'
        'date TEXT,'
        'knownBy TEXT,'
        'nameKnownBy TEXT,'
        'shift TEXT,'
        'requestBy TEXT,'
        'nameRequestedBy TEXT'
        ')');

    await db.execute('CREATE TABLE itemData('
        'id INTEGER PRIMARY KEY,'
        'permintaanId INTEGER,'
        'date TEXT,'
        'namaBarang TEXT,'
        'fisik INTEGER,'
        'satuan TEXT,'
        'keperluan TEXT,'
        'FOREIGN KEY(permintaanId) REFERENCES permintaan(id)'
        ')');
  }

  Future<int> insertPermintaan(PermintaanModel permintaan) async {
    Database db = await initDatabase();
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
      Database db = await initDatabase();

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
      Database db = await initDatabase();
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
    Database db = await initDatabase();
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

    // for (ItemDataModel item in items) {
    //   item.date = permintaan.date;
    //   await db.update('itemData', item.toMap(),
    //       where: 'id = ?', whereArgs: [item.id]);
    // }

    // for (ItemDataModel item in permintaan.items) {
    //   item.permintaanId = permintaan.id!;
    //   item.date = permintaan.date;
    //   await db.insert('itemData', item.toMap());
    // }
  }

  Future<void> deletePermintaan(int id) async {
    Database db = await initDatabase();
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
}
