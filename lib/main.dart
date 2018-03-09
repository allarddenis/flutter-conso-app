import 'package:flutter/material.dart';
import './Utils/StorageService.dart';

// Pages
import 'Pages/HomePage.dart';
import 'Pages/Vehicles/VehicleListPage.dart';
import 'Pages/Data/DataListPage.dart';

void main() {

  var storageService = new StorageService();
  var db = storageService.db;

  runApp(new MaterialApp(
    home: new HomePage(),
    theme: new ThemeData(
      primaryColor: Colors.brown[400],
      accentColor: Colors.brown[900],
    ),
    routes: <String, WidgetBuilder>{
      "/DataListPage":(BuildContext context) => new DataListPage(),
      "/VehicleListPage":(BuildContext context) => new VehicleListPage(),
    },
  ));
}