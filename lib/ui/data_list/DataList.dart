import 'package:flutter/material.dart';
import 'package:conso/Theme.dart' as Theme;
import 'package:conso/model/Data.dart';
import 'package:conso/ui/data_list/DataListRow.dart';

class DataList extends StatefulWidget {

  @override
  _DataListState createState() => new _DataListState();

}

class _DataListState extends State<DataList>{

  List<Data> data;

  @override
  void initState() {
      data = new List<Data>();

      super.initState();
  }

  void updateDataList() async {
    var dataList = await DataDao.getAll();
    setState(
      () => data = dataList
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child : new Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [
              Theme.Colors.homeBackgroundGradientStart, 
              Theme.Colors.homeBackgroundGradientEnd],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: new Column(
          children: <Widget>[
            new Expanded(
              child: new DataListView(data: data, updateListCallBack: updateDataList),
            )
          ],
        ),
      )
    );
  }
}

class DataListView extends StatelessWidget {

  final List<Data> data;
  final Function updateListCallBack;

  DataListView({this.data, this.updateListCallBack});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      padding: const EdgeInsets.all(5.0),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) => new DataListRow(data: data[index])
    );
  }

}
