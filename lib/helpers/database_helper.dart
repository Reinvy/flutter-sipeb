// ignore_for_file: depend_on_referenced_packages

import 'dart:io' as io;
import 'package:path/path.dart' as p;

import 'package:path_provider/path_provider.dart';
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
}
