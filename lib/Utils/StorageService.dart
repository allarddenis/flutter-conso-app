import 'TransportData.dart';
import 'Vehicle.dart';
import 'Storable.dart';

import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class StorageService {
  static final StorageService _instance = new StorageService.internal();
  factory StorageService() => _instance;

  static Database _db;

  Future<Database> get db async {
    print('getting storage service');
    if(_db != null)
      return _db;
    _db = await initDb();
    return _db;
  }

  StorageService.internal();

  initDb() async {
    print('init db...');
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "conso.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }
  
  void _onCreate(Database db, int version) async {
    await this.createTransportDataTable(db);
    await this.createVehicleTable(db);
  }

  Future createTransportDataTable(Database db) async {
    print('create transport data table');
    await db.execute(new TransportData().sqlCreateTable());
  }

  Future createVehicleTable(Database db) async {
    print('create vehicle data table');
    await db.execute(new Vehicle().sqlCreateTable());
  }

  Future<Storable> getDataById(Storable storable) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(
      storable.sqlTableName(),
      columns: storable.sqlColumns(),
        where: storable.sqlPrimarykeyColumn() + " = ?",
        whereArgs: [storable.getPrimaryKey()]);
    if (maps.length > 0) {
      return storable.fromMap(maps.first);
    }
    return null;
  }

  Future<int> saveData(Storable storable) async {
    var dbClient = await db;
    int res = await dbClient.insert(storable.sqlTableName(), storable.toMap());
    return res;
  }

  Future<List<Storable>> getAll(Storable storable) async {
    var dbClient = await db;
    List storables = new List();
    String table = storable.sqlTableName();
    List results = await dbClient.query(table);
    results.forEach((result){
      var td = storable.fromMap(result);
      storables.add(td);
    });
    
    return storables;
  }

  Future<int> deleteData(Storable storable) async {
    var dbClient = await db;
    return await dbClient.delete(
      storable.sqlTableName(), 
      where: storable.sqlPrimarykeyColumn() + " = ?", whereArgs: [storable.getPrimaryKey()]
    );
  }

}