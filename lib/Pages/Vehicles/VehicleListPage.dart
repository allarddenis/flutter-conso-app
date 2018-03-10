import 'package:flutter/material.dart';
import '../../Utils/Vehicle.dart';
import '../../Utils/StorageService.dart';
import '../../UI/VehicleListItem.dart';
import '../BaseWidget.dart';
import 'dart:async';
import './VehicleDialog.dart';

class VehicleListPage extends StatefulWidget {
  @override
  VehicleListState createState() => new VehicleListState();
}

class VehicleListState extends State<VehicleListPage> {

  StorageService storageService;
  List<Vehicle> vehicles = new List<Vehicle>();

  void getVehicles() async {
    storageService.getAll(new Vehicle()).then((sqlData) {
      vehicles = sqlData;
    });
  }

  @override
  void initState() {
    storageService = new StorageService();
    getVehicles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildBackground(
        content: _buildContent(context),
        title: 'Vehicles',
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.add),
            color: Colors.brown[50],
            onPressed: () => _openAddVehicleDialog(),
          )
        ]);
  }

  Future _openAddVehicleDialog() async {
    await Navigator.of(context).push(new MaterialPageRoute<bool>(
        builder: (BuildContext context) {
          return new VehicleDialog.add(new Vehicle());
        },
      fullscreenDialog: true
    )).then((val){
      if(val != null && val){
        getVehicles();
      }
    });
  }

  Future _openUpdateVehicleDialog(Vehicle vehicleToEdit) async {
    await Navigator.of(context).push(new MaterialPageRoute<bool>(
        builder: (BuildContext context) {
          return new VehicleDialog.edit(vehicleToEdit);
        },
      fullscreenDialog: true
    )).then((val){
      if(val != null && val){
        getVehicles();
      }
    }); 
  }

  Widget _buildContent(BuildContext context) {
    return new ListView.builder(
      padding: const EdgeInsets.all(5.0),
      itemCount: vehicles.length,
      itemBuilder: (BuildContext context, int index) {
        return new VehicleListItem(
          vehicle: vehicles[index],
          onTap: () => _openUpdateVehicleDialog(vehicles[index]),
        );
      },
    );
  }
}
