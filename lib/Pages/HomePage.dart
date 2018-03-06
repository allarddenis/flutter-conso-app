import 'package:flutter/material.dart';
import '../UI/MenuCardItem.dart';
import 'dart:async';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Conso App"), backgroundColor: Colors.brown,),
      backgroundColor: Colors.brown[50],
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.brown,
        child: new Icon(Icons.add),
        onPressed: (){
          _addButton(context);
          //Navigator.of(context).pushNamed("/AddTransportDataPage");
        }
      ),
      body: new Container(
        padding: new EdgeInsets.all(15.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new MenuCardItem(
              title: "Statistics", 
              icon: Icons.insert_chart,
            ),
            new MenuCardItem(
              title: "Data", 
              icon: Icons.format_list_numbered,
              route: "/TransportDataListPage",
            ),
            new MenuCardItem(
              title: "Vehicles", 
              icon: Icons.directions_car,
              route: "/VehiclePage"
            ),
            new MenuCardItem(
              title: "Preferences", 
              icon: Icons.settings,
            )
          ],
        ),
      ),
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