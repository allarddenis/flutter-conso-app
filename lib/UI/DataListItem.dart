import 'package:flutter/material.dart';
import '../Utils/Data.dart';

class DataListItem extends StatelessWidget {
  DataListItem({this.data});

  final Data data;

  @override
  Widget build(
    BuildContext context,
  ) {
    return new Container(
      padding: new EdgeInsets.only(bottom: 1.0),
        child: new Card(
          child: new Container(
            padding: new EdgeInsets.all(20.0),
            child: new Column(
              children: <Widget>[
                new ListTile(
                  title: new Text(data.toTitle(),
                  style: new TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: new Text(data.comment),
                  trailing: new Row(
                    children: <Widget>[
                      new Icon(Icons.directions_car),
                      new Text(data.vehicleId.toString())
                    ],
                  ),
                  leading: new Icon(
                    Icons.local_gas_station,
                    color: Colors.brown[600],
                  ),
                ),
              ],
            ),
    )));
  }
}
