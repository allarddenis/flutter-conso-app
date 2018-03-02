import 'package:flutter/material.dart';
import '../Utils/TransportData.dart';
import '../Utils/StorageService.dart';
import '../main.dart' as main;

class TransportDataListPage extends StatefulWidget{

  @override
  TransportDataListState createState() => new TransportDataListState();

}

class TransportDataListState extends State<TransportDataListPage>{

  StorageService storageService;
  List<TransportData> data = new List<TransportData>();

  TransportDataListState(){
    storageService = main.storageService;
  }

  void getData(){
    storageService.transportData.getAllTransportData().then((sqlData){
      data = sqlData;
    });
  }

  @override
  void initState(){
    getData();
  }

  @override
  Widget build(BuildContext context){

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
      body: new ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index){
          return new Card(
            child: new Text(data[index].comment),
          );
        },
      ));
  }
}