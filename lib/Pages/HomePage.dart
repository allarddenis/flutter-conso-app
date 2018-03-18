import 'package:flutter/material.dart';
import 'dart:async';
import './BaseWidget.dart';
import '../UI/MainItemWidget.dart';
import 'Data/DataDialog.dart';
import 'Vehicles/VehicleDialog.dart';
import '../Utils/Data.dart';
import '../Utils/Vehicle.dart';
import '../Utils/StorageService.dart';

class HomePage extends StatelessWidget {

  bool notChecked = true;

  void verifyVehicles(BuildContext context){
    notChecked = false;
    var storageService = new StorageService();
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
            color: Colors.brown[100],
            onPressed: () => Navigator.pop(context, true),
            child: new Text('OK'),
          ),
        ],
      )
    ).then((val){
      _openAddVehicleDialog(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    if(notChecked) verifyVehicles(context);
    return buildBackground(
      content: _buildContent(context), 
      title: 'Conso App',
      actions: <Widget>[
        new IconButton(
          icon: new Icon(Icons.add),
          color: Colors.brown[50],
          onPressed: ()=>_addButton(context),
        )
      ] 
    );
  }

  Widget _buildContent(BuildContext context){
    return new Material(
      color: Colors.transparent,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Expanded(
            child: new InkWell(
              onTap: () => Navigator.of(context).pushNamed("/DataListPage"),
              child: dataWidget(textSize: 30.0)
            )
          ),
          new Container(
            color: Colors.white.withOpacity(0.85),
            margin: const EdgeInsets.symmetric(horizontal: 15.0),
            width: 225.0,
            height: 1.0,
          ),
          new Expanded(
            child: new InkWell(
              onTap: ()=>Navigator.of(context).pushNamed("/VehicleListPage"),
              child: vehiclesWidget(textSize: 30.0)
            )
          ),
        ],
      )
    );
  }

  Future<Null> _addButton(BuildContext context) async {
    await showDialog<dynamic>(
      context: context,
      child: _buildAddDialogContent(context)
    );
  }

  Future _openAddDataDialog(BuildContext context) async {
    await Navigator.of(context).push(new MaterialPageRoute<bool>(
        builder: (BuildContext context) {
          return new DataDialog.add(new Data());
        },
      fullscreenDialog: true
    ));
  }

  Future _openAddVehicleDialog(BuildContext context) async {
    await Navigator.of(context).push(new MaterialPageRoute<bool>(
        builder: (BuildContext context) {
          return new VehicleDialog.add(new Vehicle());
        },
      fullscreenDialog: true
    ));
  }

  Widget _buildAddDialogContent(BuildContext context){
    return new SimpleDialog(
      title: new Text(
        "What to add ?",
        style: new TextStyle(
          fontFamily: 'Pacifico',
          color: Colors.brown[900]
        ),
      ),
      children: <Widget>[
        new ListTile(
          onTap: (){
            Navigator.of(context).pop();
            _openAddDataDialog(context);
          },
          leading: new CircleAvatar(
            backgroundColor: Colors.brown[600],
            child: new Icon(
              Icons.local_gas_station,
              color: Colors.brown[50],
            ),
          ),
          title: new Text(
            "New consumption data",
            style: new TextStyle(
              fontFamily: 'Pacifico',
              color: Colors.brown[600]
            ),
          ),
        ),
        new ListTile(
          onTap: (){
            Navigator.of(context).pop();
            _openAddVehicleDialog(context);
          },
          leading: new CircleAvatar(
            backgroundColor: Colors.brown[600],
            child: new Icon(
              Icons.directions_car,
              color: Colors.brown[50],
            ),
          ),
          title: new Text(
            "New vehicle",
            style: new TextStyle(
              fontFamily: 'Pacifico',
              color: Colors.brown[600]
            ),
          ),
        )
      ],
    );
  }

}