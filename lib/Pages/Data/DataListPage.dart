import 'package:flutter/material.dart';
import '../../Utils/Data.dart';
import '../../Utils/StorageService.dart';
import '../../UI/DataListItem.dart';
import '../BaseWidget.dart';
import 'dart:async';
import './DataDialog.dart';

class DataListPage extends StatefulWidget {
  @override
  DataListState createState() => new DataListState();
}

class DataListState extends State<DataListPage> {
  StorageService storageService;
  List<Data> data = new List<Data>();

  void getData() async {
    storageService.getAll(new Data()).then((sqlData) {
      data = sqlData;
    });
  }

  @override
  void initState() {
    storageService = new StorageService();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildBackground(
        content: _buildContent(context),
        title: 'Gas Consumption Data',
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.add),
            color: Colors.brown[50],
            onPressed: () => _openAddDataDialog(),
          )
        ]);
  }

  Future _openAddDataDialog() async {
    await Navigator.of(context).push(new MaterialPageRoute<bool>(
        builder: (BuildContext context) {
          return new DataDialog.add(new Data());
        },
      fullscreenDialog: true
    )).then((val){
      if(val != null && val){
        getData();
      }
    });
  }

  Future _openUpdateDataDialog(Data dataToEdit) async {
    await Navigator.of(context).push(new MaterialPageRoute<bool>(
        builder: (BuildContext context) {
          return new DataDialog.edit(dataToEdit);
        },
      fullscreenDialog: true
    )).then((val){
      if(val != null && val){
        getData();
      }
    }); 
  }

  Widget _buildContent(BuildContext context) {
    return new ListView.builder(
      padding: const EdgeInsets.all(5.0),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return new DataListItem(
          data: data[index],
          onTap: () => _openUpdateDataDialog(data[index]),
        );
      },
    );
  }
}
