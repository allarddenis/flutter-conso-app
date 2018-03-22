import 'package:flutter/material.dart';
import 'package:conso/model/HomeItem.dart';
import 'package:conso/ui/home/HomeItemRow.dart';
import 'package:conso/Theme.dart' as Theme;

class HomeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    List<Widget> items = new List<Widget>();

    for (var item in HomeItemDao.items) {
      items.add(
        new Expanded(
          child: new Hero(
            tag: 'home-item-${item.id}',
            child: new HomeItemRow(item),
          ),
        )
      );
    }

    return new Flexible(
      child : new Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [
              Theme.Colors.homeBackgroundGradientStart, 
              Theme.Colors.homeBackgroundGradientEnd],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: new EdgeInsets.symmetric(vertical: 30.0),
        child: new Column(children : items),
      )
    );
  }
}