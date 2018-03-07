import 'package:flutter/material.dart';
import '../../Utils/TransportData.dart';
import '../../Utils/StorageService.dart';
import '../../UI/TransportDataListItem.dart';
import '../../UI/MainItemWidget.dart';
import 'dart:ui' as ui;

class TransportDataListPage extends StatefulWidget {

  @override
  TransportDataListState createState() => new TransportDataListState();

}

class TransportDataListState extends State<TransportDataListPage>{

  StorageService storageService;
  List<TransportData> data = new List<TransportData>();
  

  void getData() async{
    storageService = new StorageService();
    storageService.getAll(new TransportData()).then((sqlData){
      data = sqlData;
    });
  }

  @override
  void initState(){
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      body : new Stack(
        fit : StackFit.expand,
        children: <Widget>[
          new Image.asset('assets/img/gas-station.jpeg', fit: BoxFit.cover),
          new Container(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new BackdropFilter(
                  filter: new ui.ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                  child: new Container(
                    color: Colors.black.withOpacity(0.66),
                    padding: new EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 10.0),
                    child: new Stack(
                      children: <Widget>[
                        new Container(
                          alignment: Alignment.center,
                          child: new Hero(
                            tag : 'transport',
                            child: transportDataWidget(textSize: 30.0),
                          )
                        ),
                        new Container(
                          alignment: Alignment.centerLeft,
                          child: new IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: new Icon(Icons.keyboard_arrow_left, color: Colors.brown[50], size: 30.0,)
                          ),
                        )
                      ],
                    )
                  )
                ),
                new Expanded(
                  child: new ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index){
                      return new TransportDataListItem(data: data[index],);
                    },
                  )
                )
              ],
            )
          ),
        ]
      )
    );
  }
}


/*
new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image.asset('assets/img/gas-station.jpeg', fit: BoxFit.cover),
          new BackdropFilter(
            filter: new ui.ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: new Container(
              color: Colors.black.withOpacity(0.66),
              child: new Container(
                padding: new EdgeInsets.all(15.0),
                child: new Column(
                  children: <Widget>[
                    new Text('Ok')
                    */