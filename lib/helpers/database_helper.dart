// ignore_for_file: depend_on_referenced_packages

import 'dart:io' as io;
import 'package:path/path.dart' as p;

import 'package:path_provider/path_provider.dart';
import 'package:sipeb/data/models/karpim_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

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
    var permintaanDb = await initDb.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
        ["permintaan"]);
    var itemDataDb = await initDb.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
        ["itemData"]);
    var karpimDb = await initDb.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
        ["karpim"]);
    if (permintaanDb.isEmpty) {
      print(permintaanDb.toString());
      await _createPermintaanDb(initDb, 1);
    }
    if (itemDataDb.isEmpty) {
      print(itemDataDb.toString());
      await _createItemDataDb(initDb, 1);
    }
    if (karpimDb.isEmpty) {
      print(karpimDb.toString());
      await _createKarpimDb(initDb, 1);

      List<KarpimModel> initKarpims = [
        KarpimModel(
          id: null,
          name: "T. Zulfikar",
          position: "Asisten Tata Usaha",
        ),
        KarpimModel(
          id: null,
          name: "Septian Burhan",
          position: "Asisten Pengolahan",
        ),
        KarpimModel(
          id: null,
          name: "RizQy Aulia",
          position: "Asisten Pengolahan",
        ),
      ];

      for (var element in initKarpims) {
        await initDb.insert(
          "karpim",
          {"name": element.name, "position": element.position},
        );
      }
    }

    return initDb;
  }

  Future<void> _createPermintaanDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE permintaan('
        'id INTEGER PRIMARY KEY,'
        'date TEXT,'
        'knownBy TEXT,'
        'nameKnownBy TEXT,'
        'shift TEXT,'
        'requestBy TEXT,'
        'nameRequestedBy TEXT'
        ')');
  }

  Future<void> _createItemDataDb(Database db, int newVersion) async {
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

  Future<void> _createKarpimDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE karpim('
        'id INTEGER PRIMARY KEY,'
        'name TEXT,'
        'position TEXT'
        ')');
  }
}
