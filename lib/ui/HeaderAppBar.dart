import 'package:conso/Theme.dart' as Theme;
import 'package:flutter/material.dart';

class HeaderAppBar extends StatelessWidget {

  final double barHeight = 66.0;
  final Function addButtonCallBack;

  HeaderAppBar({this.addButtonCallBack});

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery
      .of(context)
      .padding
      .top;

    return new Container(
      padding: new EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      child: new Container(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new BackButton(
              color: Theme.Colors.appBarIconColor
            ),
            new IconButton(
              icon: new Icon(Icons.add),
              color: Theme.Colors.appBarIconColor,
              onPressed: addButtonCallBack,
            )
          ],
        ),
      )
    );
  }
}