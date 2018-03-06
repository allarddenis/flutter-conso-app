import 'package:flutter/material.dart';
import '../Utils/Vehicle.dart';

class VehicleListItem extends StatelessWidget {

  VehicleListItem({ this.vehicle });

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context){
    return new GestureDetector(
      onTap: () {
        // TODO
      },
      child: new Container(
        padding: new EdgeInsets.only(bottom: 1.0),
        child: new Card(
          child: new Container(
            padding: new EdgeInsets.all(20.0),
            child: new Column(
              children: <Widget>[
                new ListTile(
                  title: new Text(vehicle.toTitle(),
                      style: new TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: new Text(vehicle.comment),
                  leading: new Icon(
                    Icons.directions_car,
                    color: Colors.brown[600],
                  ),
                ),
              ],
            ),
          )
        )
      ),
    );
  }
}