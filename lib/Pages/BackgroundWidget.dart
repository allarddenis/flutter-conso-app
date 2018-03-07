import 'package:flutter/material.dart';
import 'dart:ui' as ui;

Widget buildBackground(Widget content){
  return new Scaffold(
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