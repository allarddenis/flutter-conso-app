import 'package:flutter/material.dart';
import 'package:conso/ui/Header.dart';
import 'package:conso/ui/data_list/DataList.dart';
import 'package:conso/Theme.dart' as Theme;
import 'package:conso/ui/data_list/DataDialog.dart';
import 'package:conso/model/Data.dart';

class DataListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Theme.Colors.homeBackgroundGradientStart,
      body: new DataListPageBody(),
    );
  }
}

class DataListPageBody extends StatefulWidget {
  @override
  _DataListPageBodyState createState() => new _DataListPageBodyState();
}

class _DataListPageBodyState extends State<DataListPageBody> {

  void showAddDialog() async {
    await showDialog<bool>(
      context: context,
      child: new Dialog(
        child: new DataDialog.add(new Data())
      )
    ).then((val){});
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Header(
          addButtonCallBack: showAddDialog,
          img: 'assets/img/gas-station.jpeg'
        ),
        new DataList()
      ],
    );
  }
}