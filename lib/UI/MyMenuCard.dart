import 'package:flutter/material.dart';

class MyMenuCard extends StatelessWidget {

  MyMenuCard({ this.title, this.icon, this.route });

  final String title;
  final IconData icon;
  final String route;

  @override
  Widget build(BuildContext context){
    return new GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(this.route);
      },
      child: new Container(
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
      ),
    );
  }
}