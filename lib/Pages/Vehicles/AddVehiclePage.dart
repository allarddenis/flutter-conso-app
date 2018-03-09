import 'package:flutter/material.dart';
import '../../Utils/Vehicle.dart';
import '../../Utils/StorageService.dart';
import 'dart:core';

class AddVehiclePage extends StatefulWidget {

  @override
  _AddVehiclePage createState() => new _AddVehiclePage();

}

class _AddVehiclePage extends State<AddVehiclePage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  StorageService storageService;
  Vehicle vehicle;

  _AddVehiclePage(){
    storageService = new StorageService();
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
      content: new Text('Adding vehicle...'),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
    this.storageService.insertData(vehicle).then((val){
      final snackbarOK = new SnackBar(
        content: new Text('Vehicle successfully added !'),
        action: new SnackBarAction(
          label: 'Ok',
          onPressed: (){
            pop();
          },
        ),
        duration: new Duration(seconds: 3),
      );
      scaffoldKey.currentState.showSnackBar(snackbarOK);
    });
  }

  void pop(){
    if(Navigator.canPop(context)) Navigator.pop(context);
  }

  TextFormField datetime;

  @override
  Widget build(BuildContext context) {
    this.vehicle = new Vehicle();
    datetime = new TextFormField(
      decoration: new InputDecoration(labelText: 'Age in years (<50 caracters)'),
      validator: (val) =>
        val.length > 50 ? 'Name is too long : <50 caracters' : null,
      onSaved: (val) => vehicle.name = val,
    );
    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(title: new Text("Add vehicle"), backgroundColor: Colors.brown,),
      backgroundColor: Colors.brown[50],
      body: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Form(
          key: formKey,
          child: new Column(
            children: [
              new TextFormField(
                decoration: new InputDecoration(labelText: 'Name (<50 caracters)'),
                validator: (val) =>
                  val.length > 50 ? 'Name is too long : <50 caracters' : null,
                onSaved: (val) => vehicle.name = val,
              ),
              new TextFormField(
                decoration: new InputDecoration(labelText: 'Gas type (<50 caracters)'),
                validator: (val) =>
                  val.length > 50 ? 'Gas type is too long : <50 caracters' : null,
                onSaved: (val) => vehicle.gasType = val,
              ),
              new TextFormField(
                decoration: new InputDecoration(labelText: 'Comment (<50 caracters)'),
                validator: (val) =>
                  val.length > 50 ? 'Comment is too long : <50 caracters' : null,
                onSaved: (val) => vehicle.comment = val,
              ),
              new RaisedButton(
                onPressed: _submit,
                child: new Text('Add vehicle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}