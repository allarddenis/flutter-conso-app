import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'Models.dart';

class StorageService{
  JsonStorage<Vehicle> vehicles = new JsonStorage<Vehicle>('vehicles');
  JsonStorage<DataPiece> dataPieces = new JsonStorage<DataPiece>('datePieces');
}

class JsonStorage<T> {

  String fileName;
  Map<String,T> map = new Map<String, T>();
  File jsonFile;

  JsonStorage(String fileName){
    this.fileName = fileName;
    getApplicationDocumentsDirectory().then((dir){

      String fullPath = dir.path + '/' + fileName + '.json';
      this.jsonFile = new File(fullPath);

      jsonFile.exists().then((val){
        if(val){
          print(fileName + ' JSON file already exists');
          jsonFile.readAsString().then((str){
            print('JSON file read : ' + str);
            if(str.length > 0) this.map = JSON.decode(str);
          });
        }
        else{
          print('JSON file does not exist');
          jsonFile.create();
        }
      });
    });
  }

  Map<String,T> getAll() => map;

  T get(String key) => map.containsKey(key) ? map[key] : null;

  void exist(key) => this.map.containsKey(key);

  Future<bool> save(String key, T value){
    print('Saving key to ' + fileName + '.json : ' + key);
    map[key] = value;
    return saveToJson();
  }

  Future<bool> remove(key){
    map.removeWhere((k,v) => k == key);
    return saveToJson();
  }

  Future<bool> saveToJson(){
    return this.jsonFile.writeAsString(JSON.encode(this.map)).then((file){
      return true;
    });
  }

}