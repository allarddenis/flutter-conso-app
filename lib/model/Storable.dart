abstract class Storable {
  dynamic getPrimaryKey();
  String sqlCreateTable();
  String sqlTableName();
  String sqlPrimarykeyColumn();
  List<String> sqlColumns();
  Map toMap();
  Storable fromMap(Map map);
}