import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:conso/Routes.dart';
import 'package:conso/model/HomeItem.dart';
import 'package:conso/Theme.dart' as Theme;
import 'dart:ui' as ui;

class HomeItemRow extends StatelessWidget {

  final HomeItem item;

  HomeItemRow(this.item);

  @override
  Widget build(BuildContext context) {

    final itemUI = _buildItem(context);

    return new Container(
      padding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: new Container(
        child: itemUI,
        decoration: new BoxDecoration(
          color: Theme.Colors.homeItemBackgroundColors[item.id],
          borderRadius: const BorderRadius.all(const Radius.circular(20.0)),
          image: new DecorationImage(
            image: new ExactAssetImage(item.img),
            colorFilter: new ui.ColorFilter.mode(
              Colors.black.withOpacity(0.60), 
              BlendMode.dstATop
            ),
            fit: BoxFit.cover,
          ),
        ),
      )
    );
  }

  Widget _buildItem(BuildContext context){
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        onTap: () => Routes.navigateTo(
          context, 
          '/page/${item.id}',
          transition: TransitionType.fadeIn),
        child: new Container(
          alignment: Alignment.center,
          child: new Text(
            item.title,
            style: Theme.TextStyles.homeItemStyle,
          ),
        )
      )
    );
  }
}