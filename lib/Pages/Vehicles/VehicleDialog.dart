import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import '../BaseWidget.dart';
import '../../Utils/Vehicle.dart';
import '../../UI/DateTimeItem.dart';
import '../../Utils/StorageService.dart';

class VehicleDialog extends StatefulWidget {

  final Vehicle initialVehicle;
  final Vehicle vehicleToEdit;
  
  VehicleDialog.add(this.initialVehicle) : vehicleToEdit = null;

  VehicleDialog.edit(this.vehicleToEdit)
      : initialVehicle = vehicleToEdit;

  @override
  VehicleDialogState createState() {
    if (vehicleToEdit != null) {
      return new VehicleDialogState(vehicleToEdit, 'Update');
    } else {
      initialVehicle.comment = "";
      initialVehicle.gasType = "";
      initialVehicle.name = "";
      return new VehicleDialogState(initialVehicle, 'New');
    }
  }
}

class VehicleDialogState extends State<VehicleDialog> {

  final formKey = new GlobalKey<FormState>();
  List<Vehicle> vehicles = new List<Vehicle>();

  VehicleDialogState(this.vehicle, this.action);

  Vehicle vehicle;

  String action;
  int id;
  String name;
  String gasType;
  String comment;

  void getVehicles() async {
    var storageService = new StorageService();
    storageService.getAll(new Vehicle()).then((sqlVehicles){
      vehicles = sqlVehicles;
    });
  }

  @override
  void initState() {
    id = vehicle.id;
    name = vehicle.name;
    gasType = vehicle.gasType;
    comment = vehicle.comment;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildBackground(
        content: _buildContent(context),
        title: '$action vehicle',
        actions: <Widget>[
          new FlatButton(
              onPressed: () => _submit(),
              child: new Text(
                'SAVE',
                style: new TextStyle(color: Colors.brown[50]),
              )),
        ]);
  }

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      var vehicleSubmitted = new Vehicle();
      vehicleSubmitted.id = vehicle.id;
      vehicleSubmitted.name = vehicle.name;
      vehicleSubmitted.comment = comment;
      vehicleSubmitted.gasType = gasType;
      var storageService = new StorageService();
      
      if(action == 'Update') storageService.updateData(vehicleSubmitted);
      else if(action == 'New') storageService.insertData(vehicleSubmitted);
      Navigator.of(context).pop(true);
    } else {}
  }

  _deleteVehicle(){
    var storageService = new StorageService();
    storageService.deleteData(vehicle).then((val)=>
      Navigator.of(context).pop(true)
    );
  }

  Widget trailingText(String text){
    return new Text(text, style: new TextStyle(fontFamily: 'Pacifico', color: Colors.brown[400]));
  }

  Widget _buildContent(BuildContext context) {
    getVehicles();
    return new SingleChildScrollView( 
      child: new Column(
      children: <Widget>[
        new Container(
          margin: const EdgeInsets.only(top: 50.0, left: 25.0, right: 25.0),
          child: new Container(
            padding: const EdgeInsets.all(20.0),
            decoration: new BoxDecoration(
              color: Colors.white.withOpacity(0.80),
              borderRadius: new BorderRadius.circular(10.0)
            ),
            child: new Form(
              key: formKey,
              child: new Column(
                children: [
                  new TextFormField(
                    initialValue: name,
                    decoration: new InputDecoration(labelText: 'Name (<50 caracters)'),
                    validator: (val) =>
                      val.length > 50 ? 'Name is too long : <50 caracters' : null,
                    onSaved: (val) => name = val,
                  ),
                  new TextFormField(
                    initialValue: gasType,
                    decoration: new InputDecoration(labelText: 'Gas type (<50 caracters)'),
                    validator: (val) =>
                      val.length > 50 ? 'Gas type is too long : <50 caracters' : null,
                    onSaved: (val) => gasType = val,
                  ),
                  new TextFormField(
                    initialValue: comment,
                    decoration: new InputDecoration(labelText: 'Comment (<50 caracters)'),
                    validator: (val) =>
                      val.length > 50 ? 'Comment is too long : <50 caracters' : null,
                    onSaved: (val) => comment = val,
                  ),
                ],
              ),
            ),
          ),
        ),
        _buildDeleteElement(context),
      ]
    ));
  }

  Widget _buildDeleteElement(BuildContext context){
    if(action != null && action == 'Update'){
      return new GestureDetector(
        onTap: () => _showDeleteDialog(context),
        child: new Container(
          margin: const EdgeInsets.only(top: 50.0, left: 25.0, right: 25.0),
          child: new Container(
            padding: const EdgeInsets.all(20.0),
            decoration: new BoxDecoration(
              color: Colors.red[50].withOpacity(0.80),
              borderRadius: new BorderRadius.circular(10.0)
            ),
            child: new ListTile(
              leading: new CircleAvatar(
                backgroundColor: Colors.redAccent[200],
                child: new Icon(Icons.delete, color: Colors.red[50],),
              ),
              title: new Text(
                'Delete vehicle',
                style: new TextStyle(
                  color: Colors.redAccent[200],
                  fontFamily: 'Pacifico',
                  fontSize: 23.0
                ),
              ),
            )
          )
        )
      );
    }
    else{
      return new Text('');
    }
  }

  _showDeleteDialog(BuildContext context){
    showDialog<bool>(
      context: context,
      barrierDismissible: false,
      child: new AlertDialog(
        title: new Text(
          'Delete this vehicle ?',
          style: new TextStyle(
            color: Colors.redAccent[200],
          ),
        ),
        content: new Text('This action cannot be reverted !'),
        actions: <Widget>[
          new RaisedButton(
            onPressed: () => Navigator.pop(context, false),
            child: new Text('NO'),
          ),
          new RaisedButton(
            color: Colors.redAccent[200],
            onPressed: () => Navigator.pop(context, true),
            child: new Text('YES'),
          )
        ],
      )
    ).then((val){
      if(val) _deleteVehicle();
    });
  }

}
