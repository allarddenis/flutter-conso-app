import 'package:flutter/material.dart';
import '../Utils/TransportData.dart';

class TransportDataListItem extends StatelessWidget {

  TransportDataListItem({ this.data });

  final TransportData data;

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
                  title: new Text(data.toTitle(),
                      style: new TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: new Text(data.comment),
                  leading: new Icon(
                    Icons.local_gas_station,
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