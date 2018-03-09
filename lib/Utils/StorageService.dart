import 'Data.dart';
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
    if(_db != null)
      return _db;
    _db = await initDb();
    return _db;
  }

  StorageService.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "conso.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    
    /*
    Vehicle v1 = new Vehicle();
    v1.name = '208';
    v1.gasType = 'Diesel';
    v1.comment = 'Best car';
    insertData(v1);
    
    Vehicle v2 = new Vehicle();
    v2.name = '207';
    v2.gasType = 'Diesel';
    v2.comment = 'Old car';
    insertData(v2);
    */
    
    return theDb;
  }
  
  void _onCreate(Database db, int version) async {
    await this.createDataTable(db);
    await this.createVehicleTable(db);
  }

  Future createDataTable(Database db) async {
    await db.execute(new Data().sqlCreateTable());
  }

  Future createVehicleTable(Database db) async {
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

  Future<int> insertData(Storable storable) async {
    var dbClient = await db;
    int res = await dbClient.insert(storable.sqlTableName(), storable.toMap());
    return res;
  }

  Future<int> updateData(Storable storable) async {
    var dbClient = await db;
    int res = await dbClient.update(
      storable.sqlTableName(), 
      storable.toMap(),
      where: storable.sqlPrimarykeyColumn() + " = ?", 
      whereArgs: [storable.getPrimaryKey()]);
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