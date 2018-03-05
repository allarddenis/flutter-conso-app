import './Storable.dart';

final String tableVehicles = "vehicles";
final String columnId = "id";
final String columnName = "name";
final String columnGasType = "gasType";
final String columnAge = "age";

class Vehicle extends Storable {
  int id;
  String name;
  String gasType;
  String age;

  Vehicle();

  int getPrimaryKey() => id;

  String sqlPrimarykeyColumn() => tableVehicles;
  List<String> sqlColumns() => [columnId, columnName, columnGasType, columnAge];
  String sqlTableName() => tableVehicles;

  String sqlCreateTable() => 
    '''
    create table $tableVehicles ( 
      $columnId integer primary key autoincrement, 
      $columnName text not null,
      $columnGasType text not null,
      $columnAge text not null)
    ''' ;

  Map toMap() { 
    Map map = new Map();
    map["id"] = id;
    map["gasType"] = gasType;
    map["age"] = age;
    return map;
  } 

  Vehicle fromMap(Map map) { 
    id = map["id"];
    gasType = map['gasType'];
    age = map['age'];
    return this;
  }
}