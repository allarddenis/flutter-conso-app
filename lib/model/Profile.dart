import 'package:conso/model/Storable.dart';
import 'package:conso/StorageService.dart';
import 'dart:async';

final String tableProfiles = "profiles";
final String columnId = "id";
final String columnCostUnit = "costUnit";
final String columnDistanceUnit = "distanceUnit";
final String columnQuantityUnit = "quantityUnit";

class Profile extends Storable {
  int id;
  String costUnit;
  String distanceUnit;
  String quantityUnit;

  Profile();

  int getPrimaryKey() => id;

  String sqlPrimarykeyColumn() => columnId;
  List<String> sqlColumns() => [columnId, columnCostUnit, columnDistanceUnit, columnQuantityUnit];
  String sqlTableName() => tableProfiles;

  String sqlCreateTable() => 
    '''
    create table $tableProfiles ( 
      $columnId integer primary key autoincrement, 
      $columnCostUnit text not null,
      $columnDistanceUnit text not null,
      $columnQuantityUnit text not null)
    ''' ;

  Map toMap() { 
    Map map = new Map();
    map[columnId] = id;
    map[columnCostUnit] = costUnit;
    map[columnDistanceUnit] = distanceUnit;
    map[columnQuantityUnit] = quantityUnit;
    return map;
  } 

  Profile fromMap(Map map) { 
    var v = new Profile();
    v.id = map[columnId];
    v.costUnit = map[columnCostUnit];
    v.distanceUnit = map[columnDistanceUnit];
    v.quantityUnit = map[quantityUnit];
    return v;
  }
}

class ProfileDao {

  static Future<List<Profile>> getAll() async {
    var db = new StorageService();
    var profiles = await db.getAll(new Profile()) as List<Profile>;
    return profiles;
  }

  static Future<Profile> getById(int id) async {
    var db = new StorageService();
    var v = new Profile();
    v.id = id;
    var profile = await db.getDataById(v) as Profile;
    return profile;
  }

  static Future<int> add(Profile profile) async {
    var db = new StorageService();
    return await db.insertData(profile);
  }

  static Future<int> update(Profile profile) async {
    var db = new StorageService();
    return await db.updateData(profile);
  }

  static Future<int> delete(Profile profile) async {
    var db = new StorageService();
    return await db.deleteData(profile);
  }

}