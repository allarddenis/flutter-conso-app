import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import '../BaseWidget.dart';
import '../../Utils/Data.dart';
import '../../Utils/Vehicle.dart';
import '../../UI/DateTimeItem.dart';
import '../../Utils/StorageService.dart';

class DataDialog extends StatefulWidget {

  final Data initialData;
  final Data dataToEdit;
  
  DataDialog.add(this.initialData) : dataToEdit = null;

  DataDialog.edit(this.dataToEdit)
      : initialData = dataToEdit;

  @override
  DataDialogState createState() {
    if (dataToEdit != null) {
      return new DataDialogState(dataToEdit, 'Update');
    } else {
      initialData.comment = "";
      initialData.cost = 10.55;
      initialData.quantity = 10.55;
      initialData.distance = 10.55;
      initialData.date = new DateTime.now();
      return new DataDialogState(initialData, 'New');
    }
  }
}

class DataDialogState extends State<DataDialog> {

  final formKey = new GlobalKey<FormState>();
  List<Vehicle> vehicles = new List<Vehicle>();

  DataDialogState(this.data, this.action);

  Data data;

  String action;
  int vehicleId;
  String vehicleName;
  double quantity;
  double cost;
  double distance;
  String comment;
  DateTime date;

  void getVehicles() async {
    var storageService = new StorageService();
    storageService.getAll(new Vehicle()).then((sqlData){
      vehicles = sqlData;
      setState((){
        this.vehicleId = (vehicleId != null) ? this.vehicleId : vehicles.first.id;
        this.vehicleName = vehicles.firstWhere((v)=>v.id == this.vehicleId).name;
      });
    });
  }

  @override
  void initState() {
    quantity = this.data.quantity;
    cost = this.data.cost;
    distance = this.data.distance;
    date = this.data.date;
    comment = this.data.comment;
    vehicleId = (this.data.vehicleId != null) ? this.data.vehicleId : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildBackground(
        content: _buildContent(context),
        title: '$action data',
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
      var dataSubmitted = new Data();
      dataSubmitted.id = data.id;
      dataSubmitted.vehicleId = vehicleId;
      dataSubmitted.quantity = quantity;
      dataSubmitted.cost = cost;
      dataSubmitted.distance = distance;
      dataSubmitted.comment = comment;
      dataSubmitted.date = date;
      var storageService = new StorageService();
      
      if(action == 'Update') storageService.updateData(dataSubmitted);
      else if(action == 'New') storageService.insertData(dataSubmitted);
      Navigator.of(context).pop(true);
    } else {}
  }

  _deleteData(){
    var storageService = new StorageService();
    storageService.deleteData(data).then((val)=>
      Navigator.of(context).pop(true)
    );
  }

  Widget trailingText(String text){
    return new Text(text, style: new TextStyle(fontFamily: 'Pacifico', color: Colors.brown[400]));
  }

  Widget _buildContent(BuildContext context) {
    var focusNode = new FocusNode();
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
                  new ListTile(
                    leading: new Icon(Icons.today, color: Colors.brown[400]),
                    title: new DateTimeItem(
                      dateTime: date,
                      onChanged: (dateTime) => setState(() => date = dateTime),
                    ),
                  ),
                  new ListTile(
                    leading: new Icon(Icons.directions_car, color: Colors.brown[400]),
                    trailing: trailingText('vehicle'),
                    title: new GestureDetector(
                      onTap: ()=>_showVehiclePicker(context),
                      child: new Text('$vehicleName'),
                    ) 
                  ),
                  new ListTile(
                    leading: new Icon(Icons.opacity, color: Colors.brown[400]),
                    title: new Text('$quantity'),
                    trailing: trailingText('quantity'),
                    onTap: () => _showDoublePicker(context, 'Quantity'),
                  ),
                  new ListTile(
                    leading: new Icon(Icons.attach_money, color: Colors.brown[400]),
                    title: new Text('$cost'),
                    trailing: trailingText('cost'),
                    onTap: () => _showDoublePicker(context, 'Cost'),
                  ),
                  new ListTile(
                    leading: new Icon(Icons.directions, color: Colors.brown[400]),
                    title: new Text('$distance'),
                    trailing: trailingText('distance'),
                    onTap: () => _showDoublePicker(context, 'Distance'),
                  ),
                  new TextFormField(
                    maxLines: 2,
                    focusNode: focusNode,
                    decoration: new InputDecoration(
                      labelText: 'Comment (<50 caracters)'),
                    validator: (val) => val.length > 50
                      ? 'Comment is too long : <50 caracters'
                      : null,
                    onSaved: (val) => setState(()=>comment = val),
                    onFieldSubmitted: (val) => Navigator.of(context).focusScopeNode.requestFocus(focusNode),
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
                'Delete data',
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
          'Delete this data ?',
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
      if(val) _deleteData();
    });
  }

  _showVehiclePicker(BuildContext context){
    showDialog<Vehicle>(
      context: context,
      child: new SimpleDialog(
        title: new Text('Select a vehicle'),
        children: vehicles.map<Widget>((v) => 
          new SimpleDialogOption(
            child: new Text(v.toTitle()),
            onPressed: () => Navigator.pop(context, v),
          )
        ).toList(),
      )
    ).then((value){
      if(value != null){
        setState((){
          vehicleId = value.id;
          vehicleName = value.name;
        });
      }
    });
  }

  _showDoublePicker(BuildContext context, String type) {
    showDialog(
      context: context,
      child: new NumberPickerDialog.decimal(
        decimalPlaces: 2,
        minValue: 1,
        maxValue: 10000,
        initialDoubleValue: 1.0,
        title: new Text(
          type.toUpperCase(), 
          style: new TextStyle(color: Colors.brown[400], 
          fontFamily: 'Pacifico'),
        ),
      ),
    ).then((value) {
      if (value != null) {
        switch (type) {
          case 'Quantity':
            setState(() => quantity = value);
            break;
          case 'Cost':
            setState(() => cost = value);
            break;
          case 'Distance':
            setState(() => distance = value);
            break;
          default:
        }
      }
    });
  }

}
