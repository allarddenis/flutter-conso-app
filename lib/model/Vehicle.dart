import 'package:conso/model/Storable.dart';
import 'package:conso/StorageService.dart';
import 'dart:async';

final String tableVehicles = "vehicles";
final String columnId = "id";
final String columnName = "name";
final String columnGasType = "gasType";
final String columnComment = "comment";

class Vehicle extends Storable {
  int id;
  String name;
  String gasType;
  String comment;

  Vehicle();

  int getPrimaryKey() => id;

  String sqlPrimarykeyColumn() => columnId;
  List<String> sqlColumns() => [columnId, columnName, columnGasType, columnComment];
  String sqlTableName() => tableVehicles;

  String sqlCreateTable() => 
    '''
    create table $tableVehicles ( 
      $columnId integer primary key autoincrement, 
      $columnName text not null,
      $columnGasType text not null,
      $columnComment text not null)
    ''' ;

  String toTitle(){
    return name + ' (' + gasType + ')';
  }

  Map toMap() { 
    Map map = new Map();
    map[columnId] = id;
    map[columnName] = name;
    map[columnGasType] = gasType;
    map[columnComment] = comment;
    return map;
  } 

  Vehicle fromMap(Map map) { 
    var v = new Vehicle();
    v.id = map[columnId];
    v.name = map[columnName];
    v.gasType = map[columnGasType];
    v.comment = map[columnComment];
    return v;
  }
}

class VehicleDao {

  static Future<List<Vehicle>> getAll() async {
    var db = new StorageService();
    var vehicles = await db.getAll(new Vehicle()) as List<Vehicle>;
    return vehicles;
  }

  static Future<Vehicle> getById(int id) async {
    var db = new StorageService();
    var v = new Vehicle();
    v.id = id;
    var vehicle = await db.getDataById(v) as Vehicle;
    return vehicle;
  }

  static Future<int> add(Vehicle vehicle) async {
    var db = new StorageService();
    return await db.insertData(vehicle);
  }

  static Future<int> update(Vehicle vehicle) async {
    var db = new StorageService();
    return await db.updateData(vehicle);
  }

  static Future<int> delete(Vehicle vehicle) async {
    var db = new StorageService();
    return await db.deleteData(vehicle);
  }

}