abstract class Storable{
  String sqlCreateTable();
  String sqlTableName();
  Map toMap();
  Storable fromMap(Map map);
}