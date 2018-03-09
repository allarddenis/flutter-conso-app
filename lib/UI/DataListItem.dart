import 'package:flutter/material.dart';
import '../Utils/Data.dart';
import 'package:intl/intl.dart';

class DataListItem extends StatelessWidget {
  
  DataListItem({this.data, this.onTap});

  final Data data;
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
          message: data.comment,
          child : new ListTile(
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Chip(
                  avatar: new CircleAvatar(
                    child: new Icon(Icons.calendar_today, color: Colors.brown[100], size: 20.0,),
                  ),
                  backgroundColor: Colors.brown[300],
                  label: new Text(
                    new DateFormat('dd/MM/yyyy').format(data.date),
                    style: new TextStyle(color: Colors.brown[50]),
                  ),
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      data.efficiency().toString(),
                      textAlign: TextAlign.start,
                      style: new TextStyle(
                        fontFamily: 'Pacifico',
                        fontSize: 20.0
                      )
                    ),
                    new Text(
                      ' l /100km',
                      textAlign: TextAlign.start,
                      style: new TextStyle(
                        fontFamily: 'Pacifico',
                        fontSize: 15.0,
                        color: Colors.brown[400]
                      )
                    ),
                  ],
                )
              ],
            ),
            trailing: new IconButton(
              icon: new Icon(Icons.mode_edit),
              onPressed: onTap,
            )
          ),
        )
      ),
    );
  }
}
