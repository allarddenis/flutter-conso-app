import 'package:flutter/material.dart';

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
      body: new Container(
        padding: new EdgeInsets.all(15.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new MyCard(
              title: "Statistics", 
              icon: Icons.insert_chart,
            ),
            new MyCard(
              title: "Data", 
              icon: Icons.format_list_numbered,
            ),
            new MyCard(
              title: "Vehicles", 
              icon: Icons.directions_car,
            ),
            new MyCard(
              title: "Preferences", 
              icon: Icons.settings,
            )
          ],
        ),
      ),
    );
  }
}

class MyCard extends StatelessWidget {

  MyCard({ this.title, this.icon });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context){
    return new Container(
      padding: new EdgeInsets.only(bottom: 20.0),
      child: new Card(
        child: new Container(
          padding: new EdgeInsets.all(20.0),
          child: new Column(
            children: <Widget>[
              new Text(this.title, style: new TextStyle(
                fontSize: 20.0,
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto'
              ),),
              new Icon(this.icon ,size: 40.0, color: Colors.blueGrey,)
            ],
          ),
        )
      )
    );
  }
}