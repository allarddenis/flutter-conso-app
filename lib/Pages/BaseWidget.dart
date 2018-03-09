import 'package:flutter/material.dart';
import 'dart:ui' as ui;

Widget buildBackground({Widget content, String title, List<Widget> actions}){
  return new Scaffold(
    appBar: new AppBar(
      title: new Text(title, style: new TextStyle(
        color: Colors.brown[50],
        fontWeight: FontWeight.bold,
        fontFamily: 'Pacifico'
      )), 
      backgroundColor: Colors.brown[400],
      actions: actions,
    ),
    body: new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Image.asset('assets/img/gas-station.jpeg', fit: BoxFit.cover),
        new BackdropFilter(
          filter: new ui.ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
          child: new Container(
            color: Colors.black.withOpacity(0.66),
            child: content,
          ),
        ),
      ],
    ),
  );
}