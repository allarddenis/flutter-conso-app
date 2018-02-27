import 'package:flutter/material.dart';

class VehiclePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Vehicles"), backgroundColor: Colors.brown,),
      backgroundColor: Colors.brown[50],
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.brown,
        child: new Icon(Icons.add),
        onPressed: (){
          showDialog(
            context: context, 
            child: new AlertDialog(
              title: new Text("Add"),
              content:new Text("Adding vehicle..")
            )
          );
        }
      ),
      body: new Container(
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text("vehicle 1"),
              new Text("vehicle 2"),
              new Text("vehicle 3"),
            ],
          ),
        ),
      ),
    );
  }
}