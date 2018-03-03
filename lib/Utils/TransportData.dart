import 'package:sqflite/sqflite.dart';
import 'dart:async';

final String tableTransportData = "transportData";
final String columnId = "id";
final String columnVehicleId = "vehicleId";
final String columnComment = "comment";
final String columnQuantity = "quantity";
final String columnCost = "cost";
final String columnDistance = "distance";

class TransportData {
  int id;
  int vehicleId;
  String comment;
  double quantity;
  double cost;
  double distance;

  TransportData();

  String toTitle(){
    return quantity.toString() + 'L  |  ' 
      + cost.toString() + '€  |  ' 
      + distance.toString() + 'km';
  }

  Map toMap() { 
    Map map = new Map();
    map["id"] = id;
    map["vehicleId"] = vehicleId;
    map["comment"] = comment;
    map["quantity"] = quantity;
    map["cost"] = cost;
    map["distance"] = distance;
    return map;
  } 

  TransportData.fromMap(Map map) { 
    id = map["id"];
    vehicleId = map['vehicleId'];
    comment = map['comment'];
    quantity = map['quantity'];
    cost = map['cost'];
    distance = map['distance'];
  }
}

class TransportDataProvider {
  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          print('Creating ' + tableTransportData);
          await db.execute('''
create table $tableTransportData ( 
  $columnId integer primary key autoincrement, 
  $columnVehicleId integer not null,
  $columnComment text not null,
  $columnQuantity real not null,
  $columnCost real not null,
  $columnDistance real not null)
''');
          print('db created');
    });
  }

  Future<int> insertTransportData(TransportData data) async {
    return await db.inTransaction(() async {
      String query = 'INSERT INTO $tableTransportData($columnVehicleId, $columnComment, $columnQuantity, $columnCost, $columnDistance) ';
      query += 'VALUES(' + data.vehicleId.toString() + ', \"' + data.comment + '\", ' + data.quantity.toString() + ', ' + data.cost.toString() + ', ' + data.distance.toString() + ')';
      print(query);
      int id1 = await db.rawInsert(query);
      print("inserted1: $id1");
    });
  }

  Future<List<TransportData>> getAllTransportData() async {
    List<TransportData> transportData = new List<TransportData>();
    await db.rawQuery('SELECT * FROM ' + tableTransportData).then((maps){
      maps.forEach((map){
        transportData.add(new TransportData.fromMap(map));
      });
    });
    
    return transportData;
  }

  Future<TransportData> getTransportData(int id) async {
    List<Map> maps = await db.query(tableTransportData,
        columns: [columnId, columnVehicleId, columnComment, columnQuantity, columnCost, columnDistance],
        where: "$columnId = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return new TransportData.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete(tableTransportData, where: "$columnId = ?", whereArgs: [id]);
  }

  Future<int> update(TransportData data) async {
    return await db.update(tableTransportData, data.toMap(),
        where: "$columnId = ?", whereArgs: [data.id]);
  }

  Future close() async => db.close();
}