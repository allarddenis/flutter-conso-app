import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'TransportData.dart';
import 'Vehicle.dart';

class StorageService{

  StorageService(){
    print('Creating db service.');
    getApplicationDocumentsDirectory().then((dir){
      documentsDirectory = dir;
      path = documentsDirectory.path +  "/conso.db";
      vehicles.open(path);
      transportData.open(path);
    });
  }

  Directory documentsDirectory;
  String path;

  TransportDataProvider transportData = new TransportDataProvider();
  VehicleProvider vehicles = new VehicleProvider();
}

