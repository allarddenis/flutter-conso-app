import 'package:flutter/material.dart';
import 'package:conso/Theme.dart' as Theme;

class HomeAppBar extends StatelessWidget {

  final String title;
  final double barHeight = 66.0;

  HomeAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery
      .of(context)
      .padding
      .top;

    return new Container(
      padding: new EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      child: new Center(
        child: new Text(
          title,
          style: Theme.TextStyles.homeAppBarStyle,
        ),
      ),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [Theme.Colors.homeAppBarGradientStart, Theme.Colors.homeAppBarGradientEnd],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}