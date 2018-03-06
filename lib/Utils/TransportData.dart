import './Storable.dart';

final String tableTransportData = "transportData";
final String columnId = "id";
final String columnVehicleId = "vehicleId";
final String columnComment = "comment";
final String columnQuantity = "quantity";
final String columnCost = "cost";
final String columnDistance = "distance";

class TransportData extends Storable {
  int id;
  int vehicleId;
  String comment;
  double quantity;
  double cost;
  double distance;

  TransportData();

  int getPrimaryKey() => id;

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
    map[columnId] = id;
    map[columnVehicleId] = vehicleId;
    map[columnComment] = comment;
    map[columnQuantity] = quantity;
    map[columnCost] = cost;
    map[columnDistance] = distance;
    return map;
  } 

  TransportData fromMap(Map map) { 
    var td = new TransportData();
    td.id = map[columnId];
    td.vehicleId = map[columnVehicleId];
    td.comment = map[columnComment];
    td.quantity = map[columnQuantity];
    td.cost = map[columnCost];
    td.distance = map[columnDistance];
    return td;
  }
}