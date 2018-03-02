import 'package:sqflite/sqflite.dart';
import 'dart:async';

final String tableVehicles = "vehicles";
final String columnId = "id";
final String columnName = "name";
final String columnGasType = "gasType";
final String columnAge = "age";

class Vehicle {
  int id;
  String name;
  String gasType;
  String age;

  Vehicle();

  Map toMap() { 
    Map map = new Map();
    map["id"] = id;
    map["gasType"] = gasType;
    map["age"] = age;
    return map;
  } 

  Vehicle.fromMap(Map map) { 
    id = map["id"];
    gasType = map['gasType'];
    age = map['age'];
  }
}

class VehicleProvider {
  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableVehicles ( 
  $columnId integer primary key autoincrement, 
  $columnName text not null,
  $columnGasType text not null,
  $columnAge text not null)
''');
    });
  }

  Future<Vehicle> insert(Vehicle vehicle) async {
    vehicle.id = await db.insert(tableVehicles, vehicle.toMap());
    return vehicle;
  }

  Future<List<Vehicle>> getAllVehicles() async {
    List<Vehicle> vehicles = new List<Vehicle>();
    await db.rawQuery('SELECT * FROM ' + tableVehicles).then((maps){
      maps.forEach((map){
        vehicles.add(new Vehicle.fromMap(map));
      });
    });
    
    return vehicles;
  }

  Future<Vehicle> getVehicle(int id) async {
    List<Map> maps = await db.query(tableVehicles,
        columns: [columnId, columnName, columnGasType, columnAge],
        where: "$columnId = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return new Vehicle.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete(tableVehicles, where: "$columnId = ?", whereArgs: [id]);
  }

  Future<int> update(Vehicle vehicle) async {
    return await db.update(tableVehicles, vehicle.toMap(),
        where: "$columnId = ?", whereArgs: [vehicle.id]);
  }

  Future close() async => db.close();
}