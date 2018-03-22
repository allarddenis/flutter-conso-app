import 'package:flutter/material.dart';
import 'package:conso/Theme.dart' as Theme;
import 'package:conso/ui/HeaderAppBar.dart';

class Header extends StatelessWidget {

  final Function addButtonCallBack;
  final String img;

  Header({this.addButtonCallBack, this.img});

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new Container(
          foregroundDecoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [ Colors.transparent, Theme.Colors.homeAppBarGradientEnd ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,),),
          child: new Image.asset(this.img, fit: BoxFit.fitHeight,),),
        new HeaderAppBar(addButtonCallBack: this.addButtonCallBack),
      ],
    );
  }
}