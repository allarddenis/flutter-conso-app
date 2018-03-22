import 'package:flutter/material.dart';
import 'package:conso/ui/Header.dart';
import 'package:conso/Theme.dart' as Theme;

class VehicleListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Theme.Colors.homeBackgroundGradientStart,
      body: new VehicleListPageBody(),
    );
  }
}

class VehicleListPageBody extends StatefulWidget {
  @override
  _VehicleListPageBodyState createState() => new _VehicleListPageBodyState();
}

class _VehicleListPageBodyState extends State<VehicleListPageBody> {

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Header(
          addButtonCallBack: ()=>{},
          img: 'assets/img/car.jpeg'
        ),
        new Expanded( 
          child: new Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [
                  Theme.Colors.homeBackgroundGradientStart, 
                  Theme.Colors.homeBackgroundGradientEnd],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        )
      ],
    );
  }
}