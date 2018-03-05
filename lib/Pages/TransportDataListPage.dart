import 'package:flutter/material.dart';
import '../Utils/TransportData.dart';
import '../Utils/StorageService.dart';
import '../UI/TransportDataListItem.dart';

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
      appBar: new AppBar(title: new Text("Conso App"), backgroundColor: Colors.brown,),
      backgroundColor: Colors.brown[50],
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.brown,
        child: new Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).pushNamed("/AddTransportDataPage").then((val){
            getData();
          });
        }
      ),
      body: new ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index){
          return new TransportDataListItem(data: data[index],);
        },
      ));
  }
}