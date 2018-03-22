import 'package:flutter/material.dart';
import 'package:conso/Routes.dart';
import 'package:conso/ui/home/HomePage.dart';
import 'package:flutter/services.dart';

void main() {
  Routes.initRoutes();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(new MaterialApp(
    title: "Planets",
    home: new HomePage(),
  ));
}