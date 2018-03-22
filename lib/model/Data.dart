import 'package:conso/model/Storable.dart';
import 'package:conso/StorageService.dart';
import 'dart:async';

final String tableData = "data";
final String columnId = "id";
final String columnVehicleId = "vehicleId";
final String columnComment = "comment";
final String columnQuantity = "quantity";
final String columnCost = "cost";
final String columnDistance = "distance";
final String columnDate = "date";

class Data extends Storable {
  int id;
  int vehicleId;
  String comment;
  double quantity;
  double cost;
  double distance;
  DateTime date;

  Data();

  int getPrimaryKey() => id;

  String sqlPrimarykeyColumn() => columnId;
  List<String> sqlColumns() => 
    [ columnId, columnVehicleId, columnComment, columnQuantity, columnCost, columnDistance, columnDate];
  String sqlTableName() => tableData;

  String sqlCreateTable() => 
    '''
    create table $tableData ( 
      $columnId integer primary key autoincrement, 
      $columnVehicleId integer not null,
      $columnComment text not null,
      $columnQuantity real not null,
      $columnCost real not null,
      $columnDistance real not null,
      $columnDate text not null)
    ''';

  String efficiency(){
    return (quantity * 100 / distance).toStringAsPrecision(3);
  }

  String toTitle(){
    return quantity.toString() + 'L  |  ' 
      + cost.toString() + '€  |  ' 
      + distance.toString() + 'km';
  }

  Map toMap() { 
    Map map = new Map();
    map[columnId] = id;
    map[columnVehicleId] = vehicleId;
    map[columnComment] = comment;
    map[columnQuantity] = quantity;
    map[columnCost] = cost;
    map[columnDistance] = distance;
    map[columnDate] = date.toIso8601String();
    return map;
  } 

  Data fromMap(Map map) { 
    var td = new Data();
    td.id = map[columnId];
    td.vehicleId = map[columnVehicleId];
    td.comment = map[columnComment];
    td.quantity = map[columnQuantity];
    td.cost = map[columnCost];
    td.distance = map[columnDistance];
    td.date = DateTime.parse(map[columnDate]);
    return td;
  }
}

class DataDao {

  static Future<List<Data>> getAll() async {
    var db = new StorageService();
    var data = await db.getAll(new Data()) as List<Data>;
    return data;
  }

  static Future<Data> getById(int id) async {
    var db = new StorageService();
    var v = new Data();
    v.id = id;
    var data = await db.getDataById(v) as Data;
    return data;
  }

  static Future<int> add(Data data) async {
    var db = new StorageService();
    return await db.insertData(data);
  }

  static Future<int> update(Data data) async {
    var db = new StorageService();
    return await db.updateData(data);
  }

  static Future<int> delete(Data data) async {
    var db = new StorageService();
    return await db.deleteData(data);
  }

}