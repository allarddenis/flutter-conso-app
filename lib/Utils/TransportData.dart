import './Storable.dart';

final String tableTransportData = "transportData";
final String columnId = "id";
final String columnVehicleId = "vehicleId";
final String columnComment = "comment";
final String columnQuantity = "quantity";
final String columnCost = "cost";
final String columnDistance = "distance";

class TransportData extends Storable{
  int id;
  int vehicleId;
  String comment;
  double quantity;
  double cost;
  double distance;

  TransportData();

  String sqlPrimarykeyColumn() => columnId;
  List<String> sqlColumns() => 
    [ columnId, columnVehicleId, columnComment, columnQuantity, columnCost, columnDistance];
  String sqlTableName() => tableTransportData;

  String sqlCreateTable() => 
    '''
    create table $tableTransportData ( 
      $columnId integer primary key autoincrement, 
      $columnVehicleId integer not null,
      $columnComment text not null,
      $columnQuantity real not null,
      $columnCost real not null,
      $columnDistance real not null)
    ''';

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

  TransportData fromMap(Map map) { 
    id = map["id"];
    vehicleId = map['vehicleId'];
    comment = map['comment'];
    quantity = map['quantity'];
    cost = map['cost'];
    distance = map['distance'];
    return this;
  }
}