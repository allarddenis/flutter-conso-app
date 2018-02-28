import 'package:flutter/material.dart';
import './Utils/StorageService.dart';

// Pages
import 'Pages/AddDataPage.dart';
import 'Pages/HomePage.dart';
import 'Pages/LoginPage.dart';
import 'Pages/VehiclePage.dart';

final storageService = new StorageService();

void main() {

  runApp(new MaterialApp(
    home: new HomePage(),
    routes: <String, WidgetBuilder>{
      "/AddDataPage":(BuildContext context) => new AddDataPage(),
      "/LoginPage":(BuildContext context) => new LoginPage(),
      "/VehiclePage":(BuildContext context) => new VehiclePage(),
    },
  ));
}