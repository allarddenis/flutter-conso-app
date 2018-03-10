import 'package:flutter/material.dart';
import '../Utils/Vehicle.dart';

class VehicleListItem extends StatelessWidget {

  VehicleListItem({ this.vehicle, this.onTap });

  final Vehicle vehicle;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: new Container(
        decoration: new BoxDecoration(
          color: Colors.white.withOpacity(0.80),
          borderRadius: new BorderRadius.circular(10.0),
          boxShadow: <BoxShadow>[
            new BoxShadow(
              spreadRadius: 2.0,
              blurRadius: 10.0,
              color: Colors.black26,
            ),
          ],
        ),
        child: new Tooltip(
          message: vehicle.comment,
          child : new ListTile(
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Chip(
                  avatar: new CircleAvatar(
                    child: new Icon(Icons.opacity, color: Colors.brown[100], size: 20.0,),
                  ),
                  backgroundColor: Colors.brown[300],
                  label: new Text(vehicle.gasType),
                ),
                new Text(
                  vehicle.name,
                  style: new TextStyle(
                    fontFamily: 'Pacifico',
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    color: Colors.brown[900],
                  )
                ),
                new IconButton(
                  icon: new Icon(Icons.mode_edit),
                  onPressed: onTap,
                  color: Colors.brown[900],
                )
              ],
            ),
          ),
        )
      ),
    );
  }

}