import 'package:flutter/material.dart';
import '../UI/MenuCardItem.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Conso App"), backgroundColor: Colors.brown,),
      backgroundColor: Colors.brown[50],
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.brown,
        child: new Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).pushNamed("/AddTransportDataPage");
        }
      ),
      body: new Container(
        padding: new EdgeInsets.all(15.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new MenuCardItem(
              title: "Statistics", 
              icon: Icons.insert_chart,
            ),
            new MenuCardItem(
              title: "Data", 
              icon: Icons.format_list_numbered,
              route: "/TransportDataListPage",
            ),
            new MenuCardItem(
              title: "Vehicles", 
              icon: Icons.directions_car,
              route: "/VehiclePage"
            ),
            new MenuCardItem(
              title: "Preferences", 
              icon: Icons.settings,
            )
          ],
        ),
      ),
    );
  }
}