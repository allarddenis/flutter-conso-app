import 'package:flutter/material.dart';
import '../../Utils/TransportData.dart';
import '../../Utils/Vehicle.dart';
import '../../Utils/StorageService.dart';
import 'dart:core';

enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

class AddTransportDataPage extends StatefulWidget {

  @override
  _AddTransportDataPage createState() => new _AddTransportDataPage();

}

class _AddTransportDataPage extends State<AddTransportDataPage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  StorageService storageService;
  TransportData data;
  List<Vehicle> vehicles = new List<Vehicle>();

  _AddTransportDataPage(){
    storageService = new StorageService();
  }

  void getVehicles() async{
    storageService = new StorageService();
    storageService.getAll(new Vehicle()).then((sqlData){
      vehicles = sqlData;
    });
  }

  @override
  void initState(){
    getVehicles();
    super.initState();
  }

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      _performAddAction();
    } else {
      final snackbar = new SnackBar(
        content: new Text('Please verify inputs are correct.'),
      );
      scaffoldKey.currentState.showSnackBar(snackbar);
    }
  }

  void _performAddAction() {

    final snackbar = new SnackBar(
      content: new Text('Adding data...'),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);

    this.storageService.saveData(data).then((val){
      final snackbarOK = new SnackBar(
        content: new Text('Data successfully added !'),
      );

      scaffoldKey.currentState.showSnackBar(snackbarOK);

      if(Navigator.canPop(context)) Navigator.pop(context, true);
    });
  }

  String validate(String str){
    try {
      var temp = double.parse(getFormatString(str));
      return temp < 0.0 ? 'Not a positive number' : null;
    } catch(e){
      return 'Not a double.';
    }
  }

  String validateInt(String str){
    try {
      var temp = int.parse(str);
      return temp < 0 ? 'Not a positive number' : null;
    } catch(e){
      return 'Not an integer.';
    }
  }

  String getFormatString(String str){
    var formatStr = str.replaceAll(',', '.');
    if(str.indexOf('.') < 0) formatStr += '.';
    return formatStr;
  }

  @override
  Widget build(BuildContext context) {
    this.data = new TransportData();
    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(title: new Text("Add data"), backgroundColor: Colors.brown,),
      backgroundColor: Colors.brown[50],
      body: new Padding(
        padding: const EdgeInsets.all(50.0),
        child: new Form(
          key: formKey,
          child: new Column(
            children: [
              new PopupMenuButton<Vehicle>(
                initialValue: vehicles.first,
                icon: new Icon(Icons.directions_car),
                onSelected: (Vehicle v) { setState(() { data.vehicleId = v.id; }); },
                itemBuilder: (BuildContext context){
                  return vehicles.map((v)=>
                    new PopupMenuItem<Vehicle>(
                      value: v,
                      child: new Text(v.name),
                    )
                  ).toList();
                },
              ),
              new TextFormField(
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(labelText: 'Quantity (in Liters)'),
                validator: (val) => validate(val),
                onSaved: (val){
                  this.setState(()=>data.quantity = double.parse(getFormatString(val)));
                },
              ),
              new TextFormField(
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(labelText: 'Distance (in Km)'),
                validator: (val) => validate(val),
                onSaved: (val){
                  this.setState(()=>data.distance = double.parse(getFormatString(val)));
                },
              ),
              new TextFormField(
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(labelText: 'Cost (in Euros)'),
                validator: (val) => validate(val),
                onSaved: (val){
                  this.setState(()=>data.cost = double.parse(getFormatString(val)));
                },
              ),
              new TextFormField(
                decoration: new InputDecoration(labelText: 'Comment (<50 caracters)'),
                validator: (val) =>
                  val.length > 50 ? 'Comment is too long : <50 caracters' : null,
                onSaved: (val) => data.comment = val,
              ),
              new RaisedButton(
                onPressed: _submit,
                child: new Text('Add data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}