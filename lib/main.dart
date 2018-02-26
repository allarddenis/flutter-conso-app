import 'package:flutter/material.dart';
import 'UI/MyMenuCard.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyStatelessWidget()
  ));
}

class MyStatelessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Conso App"), backgroundColor: Colors.brown,),
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
        padding: new EdgeInsets.all(15.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new MyMenuCard(
              title: "Statistics", 
              icon: Icons.insert_chart,
            ),
            new MyMenuCard(
              title: "Data", 
              icon: Icons.format_list_numbered,
            ),
            new MyMenuCard(
              title: "Vehicles", 
              icon: Icons.directions_car,
            ),
            new MyMenuCard(
              title: "Preferences", 
              icon: Icons.settings,
            )
          ],
        ),
      ),
    );
  }
}