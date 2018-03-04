import 'package:flutter/material.dart' as material;
import './Utils/StorageService.dart';

// Pages
import 'Pages/AddTransportDataPage.dart';
import 'Pages/TransportDataListPage.dart';
import 'Pages/HomePage.dart';
import 'Pages/LoginPage.dart';
import 'Pages/VehiclePage.dart';

void main() {

  var storageService = new StorageService();
  var db = storageService.db;

  material.runApp(new material.MaterialApp(
    home: new HomePage(),
    routes: <String, material.WidgetBuilder>{
      "/AddTransportDataPage":(material.BuildContext context) => new AddTransportDataPage(),
      "/TransportDataListPage":(material.BuildContext context) => new TransportDataListPage(),
      "/LoginPage":(material.BuildContext context) => new LoginPage(),
      "/VehiclePage":(material.BuildContext context) => new VehiclePage(),
    },
  ));
}