import 'package:flutter/material.dart';
import 'dart:async';
import './BackgroundWidget.dart';
import '../UI/MainItemWidget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildBackground(_buildContent(context));
  }

  Widget _buildContent(BuildContext context){
    return new Container(
      padding: new EdgeInsets.all(15.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Expanded(
            child: new GestureDetector(
              onTap: ()=>Navigator.of(context).pushNamed("/TransportDataListPage"),
              child: new Hero(
                tag: 'transport',
                child: transportDataWidget(textSize: 50.0),
              )
            )
          ),
          new Container(
            color: Colors.white.withOpacity(0.85),
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            width: 225.0,
            height: 1.0,
          ),
          new Expanded(
            child: new GestureDetector(
              onTap: ()=>Navigator.of(context).pushNamed("/VehicleListPage"),
              child: new Hero(
                tag : 'vehicles',
                child: vehiclesWidget(textSize: 50.0),
              )
            )
          ),
        ],
      )
    );
  }

  Future<Null> _addButton(BuildContext context) async {
    const String vehicleChoice = "Vehicle";
    const String transportDataChoice = 'Transport data';
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
                Navigator.pop(context, transportDataChoice);
              },
              child: const Text(transportDataChoice),
            ),
          ],
        ),
    )){
      case vehicleChoice:
        Navigator.of(context).pushNamed("/AddVehiclePage");
      break;
      case transportDataChoice:
        Navigator.of(context).pushNamed("/AddTransportDataPage");
      break;
    }
  }

}