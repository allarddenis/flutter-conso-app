import 'package:flutter/material.dart';
import '../../Utils/Data.dart';
import '../../Utils/Vehicle.dart';
import '../../Utils/StorageService.dart';
import '../../UI/DataListItem.dart';
import '../BaseWidget.dart';
import 'dart:async';
import './DataDialog.dart';
import '../Vehicles/VehicleDialog.dart';

class DataListPage extends StatefulWidget {
  @override
  DataListState createState() => new DataListState();
}

class DataListState extends State<DataListPage> {
  StorageService storageService;
  List<Data> data = new List<Data>();

  void getData() async {
    storageService.getAll(new Data()).then((sqlData) {
      data = sqlData;
    });
  }

  @override
  void initState() {
    storageService = new StorageService();
    getData();
    verifyVehicles(context);
    super.initState();
  }

  void verifyVehicles(BuildContext context){
    storageService.getAll(new Vehicle()).then((val){
      if(val.length <= 0) showNoVehiclesDialog(context);
    });
  }

  void showNoVehiclesDialog(BuildContext context) async {
    await showDialog<bool>(
      context: context,
      child: new AlertDialog(
        title: new Text(
          "First, add a vehicle !",
          style: new TextStyle(
            fontFamily: 'Pacifico',
            color: Colors.brown[900]
          ),
        ),
        content: new Text(
          "It's so simple..",
          style: new TextStyle(
            fontFamily: 'Pacifico',
            color: Colors.brown[900]
          ),
        ),
        actions: <Widget>[
          new RaisedButton(
            onPressed: () => Navigator.pop(context, true),
            child: new Text('OK'),
          ),
        ],
      )
    ).then((val){
      _openAddVehicleDialog(context);
    });
  }

  Future _openAddVehicleDialog(BuildContext context) async {
    await Navigator.of(context).push(new MaterialPageRoute<bool>(
        builder: (BuildContext context) {
          return new VehicleDialog.add(new Vehicle());
        },
      fullscreenDialog: true
    ));
  }

  @override
  Widget build(BuildContext context) {
    return buildBackground(
        content: _buildContent(context),
        title: 'Gas Consumption Data',
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.add),
            color: Colors.brown[50],
            onPressed: () => _openAddDataDialog(),
          )
        ]);
  }

  Future _openAddDataDialog() async {
    await Navigator.of(context).push(new MaterialPageRoute<bool>(
        builder: (BuildContext context) {
          return new DataDialog.add(new Data());
        },
      fullscreenDialog: true
    )).then((val){
      if(val != null && val){
        getData();
      }
    });
  }

  Future _openUpdateDataDialog(Data dataToEdit) async {
    await Navigator.of(context).push(new MaterialPageRoute<bool>(
        builder: (BuildContext context) {
          return new DataDialog.edit(dataToEdit);
        },
      fullscreenDialog: true
    )).then((val){
      if(val != null && val){
        getData();
      }
    }); 
  }

  Widget _buildContent(BuildContext context) {
    return new ListView.builder(
      padding: const EdgeInsets.all(5.0),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return new DataListItem(
          data: data[index],
          onTap: () => _openUpdateDataDialog(data[index]),
        );
      },
    );
  }
}
