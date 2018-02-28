class Vehicle {
  String gasType;
  DateTime age;

  Map toJson() { 
    print('ToJSON : vehicle');
    Map map = new Map();
    map["gasType"] = gasType;
    map["age"] = age.toIso8601String();
    return map;
  } 
}

class DataPiece {
  String vehiculeKey;
  String comment;
  double quantity;
  double cost;
  double distance;

  Map toJson() { 
    print('ToJSON : datapiece');
    Map map = new Map();
    map["comment"] = comment;
    map["quantity"] = quantity;
    map["cost"] = cost;
    map["distance"] = distance;
    return map;
  } 
}