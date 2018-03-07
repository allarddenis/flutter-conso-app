import 'package:flutter/material.dart' as material;
import './Utils/StorageService.dart';

// Pages
import 'Pages/HomePage.dart';
import 'Pages/LoginPage.dart';
import 'Pages/Vehicles/VehicleListPage.dart';
import 'Pages/Vehicles/AddVehiclePage.dart';
import 'Pages/Transport-data/AddTransportDataPage.dart';
import 'Pages/Transport-data/TransportDataListPage.dart';

void main() {

  var storageService = new StorageService();
  var db = storageService.db;

  material.runApp(new material.MaterialApp(
    home: new HomePage(),
    routes: <String, material.WidgetBuilder>{
      "/AddTransportDataPage":(material.BuildContext context) => new AddTransportDataPage(),
      "/TransportDataListPage":(material.BuildContext context) => new TransportDataListPage(),
      "/LoginPage":(material.BuildContext context) => new LoginPage(),
      "/VehicleListPage":(material.BuildContext context) => new VehicleListPage(),
      "/AddVehiclePage":(material.BuildContext context) => new AddVehiclePage(),
    },
  ));
}