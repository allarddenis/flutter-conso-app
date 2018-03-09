import 'package:flutter/material.dart';

Widget dataWidget({double textSize}){
  return new Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      new Text('Gas', style: new TextStyle(
        fontSize: textSize,
        color: Colors.brown[50],
        fontWeight: FontWeight.bold,
        fontFamily: 'Pacifico'
      )),
      new Text('Consumption', style: new TextStyle(
        fontSize: textSize,
        color: Colors.brown[50],
        fontWeight: FontWeight.bold,
        fontFamily: 'Pacifico'
      ))
    ],
  );
}

Widget vehiclesWidget({double textSize}){
  return new Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      new Text('Vehicles', style: new TextStyle(
        fontSize: textSize,
        color: Colors.brown[50],
        fontWeight: FontWeight.bold,
        fontFamily: 'Pacifico'
      )),
    ],
  );
}