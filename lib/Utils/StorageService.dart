import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import './DataPiece.dart';
import './Vehicle.dart';

class StorageService {

  File jsonFile;
  String fileName = "data.json";
  Map<String, Vehicle> data;

  Directory directory;

  StorageService(){
    this.data = new Map<String, Vehicle>();
    getApplicationDocumentsDirectory().then((dir){
      this.directory = dir;
      this.jsonFile = new File(directory.path + '/' + fileName);
      jsonFile.exists().then((val){
        if(val){
          jsonFile.readAsString().then((str){
            this.data = JSON.decode(str);
          });
        }
        else{
          jsonFile.create();
        }
      });
    });
  }

  Map<String, Vehicle> getAllData(){
    return this.data;
  }

  Vehicle getVehicle(String name){
    return this.data[name];
  }

  List<DataPiece> getVehicleData(String name){
    return this.data[name].data;
  }

  void saveVehicle(Vehicle newData){
    this.data[newData.name] = newData;
    this.jsonFile.writeAsStringSync(JSON.encode(this.data));
  }

  bool saveDataPiece(String vehicleName, DataPiece dataPiece){
    if(this.data.containsKey(vehicleName)){
      this.data[vehicleName].data.add(dataPiece);
      this.jsonFile.writeAsStringSync(JSON.encode(this.data));
    }
    else{
      var vehicle = new Vehicle();
      vehicle.name = vehicleName;
      vehicle.data = new List<DataPiece>(1);
      vehicle.data.add(dataPiece);
      this.data[vehicleName] = vehicle;
      var str = JSON.encode(this.data);
      print('[APP] data :' + str);
      this.jsonFile.writeAsStringSync(str);
    }
    
    return true;
  }

}