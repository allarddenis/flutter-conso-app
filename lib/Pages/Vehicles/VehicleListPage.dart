import 'package:flutter/material.dart';
import '../../Utils/Vehicle.dart';
import '../../Utils/StorageService.dart';
import '../../UI/VehicleListItem.dart';

class VehicleListPage extends StatefulWidget {

  @override
  VehicleListState createState() => new VehicleListState();

}

class VehicleListState extends State<VehicleListPage>{

  StorageService storageService;
  List<Vehicle> vehicles = new List<Vehicle>();
  

  void getData() async{
    storageService = new StorageService();
    storageService.getAll(new Vehicle()).then((sqlData){
      vehicles = sqlData;
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
          Navigator.of(context).pushNamed("/AddVehiclePage").then((val){
            getData();
          });
        }
      ),
      body: new Container(
        child: new ListView.builder(
          itemCount: vehicles.length,
          itemBuilder: (BuildContext context, int index){
            return new VehicleListItem(vehicle: vehicles[index],);
          },
        ),
      )
    );
  }
}