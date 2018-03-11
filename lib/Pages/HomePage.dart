import 'package:flutter/material.dart';
import 'dart:async';
import './BaseWidget.dart';
import '../UI/MainItemWidget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
    return new Container(
      padding: new EdgeInsets.all(15.0),
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
            margin: const EdgeInsets.symmetric(vertical: 16.0),
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
    const String vehicleChoice = "Vehicle";
    const String dataChoice = 'Data';
    switch (
      await showDialog<String>(
        context: context,
        child: new SimpleDialog(
          title: const Text('What to add ?'),
          children: <Widget>[
            new SimpleDialogOption(
              onPressed: () { 
                Navigator.pop(context, vehicleChoice);
              },
              child: const Text(vehicleChoice),
            ),
            new SimpleDialogOption(
              onPressed: () { 
                Navigator.pop(context, dataChoice);
              },
              child: const Text(dataChoice),
            ),
          ],
        ),
    )){
      case vehicleChoice:
        Navigator.of(context).pushNamed("/AddVehiclePage");
      break;
      case dataChoice:
        Navigator.of(context).pushNamed("/AddDataPage");
      break;
    }
  }

}