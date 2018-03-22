import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:conso/ui/data_list/DataDialog.dart';
import 'package:conso/ui/data_list/DataListPage.dart';
import 'package:conso/ui/vehicle_list/VehicleListPage.dart';

class Routes {
  static final Router _router = new Router();

  static var dataListHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new DataListPage();
    });

  static var vehicleListHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new VehicleListPage();
    });

  static var vehicleListAddHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new DataDialog.add(params["data"]);
    });

  static var vehicleListUpdateHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new DataDialog.edit(params["data"]);
    });

  static void initRoutes() {
    _router.define("/page/0", handler: dataListHandler);
    _router.define("/page/0/add", handler: vehicleListAddHandler);
    _router.define("/page/0/update", handler: vehicleListUpdateHandler);
    _router.define("/page/1", handler: vehicleListHandler);
  }

  static void navigateTo(context, String route, {TransitionType transition}) {
    _router.navigateTo(context, route, transition: transition);
  }

}