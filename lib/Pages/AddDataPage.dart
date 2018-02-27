import 'package:flutter/material.dart';
import '../Utils/DataPiece.dart';

class AddDataPage extends StatefulWidget {
  @override
  _AddDataPage createState() => new _AddDataPage();
}

class _AddDataPage extends State<AddDataPage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  DataPiece data;

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      // Email & password matched our validation rules
      // and are saved to _email and _password fields.
      _performAddAction();
    }
  }

  void _performAddAction() {
    // This is just a demo, so no actual login here.
    final snackbar = new SnackBar(
      content: new Text('Adding data...'),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(title: new Text("Add data"), backgroundColor: Colors.brown,),
      backgroundColor: Colors.brown[50],
      body: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Form(
          key: formKey,
          child: new Column(
            children: [
              new TextFormField(
                decoration: new InputDecoration(labelText: 'Quantity (in Liters)'),
                validator: (val){
                  try {
                    var temp = double.parse(val.replaceAll(',', '.'));
                    return temp < 0.0 ? 'Not a positive number' : null;
                  } catch(e){
                    return 'Not a double.';
                  }
                },
                onSaved: (val) => data.quantity = double.parse(val.replaceAll(',', '.')),
              ),
              new TextFormField(
                decoration: new InputDecoration(labelText: 'Distance (in Km)'),
                validator: (val){
                  try {
                    var temp = double.parse(val.replaceAll(',', '.'));
                    return temp < 0.0 ? 'Not a positive number' : null;
                  } catch(e){
                    return 'Not a double.';
                  }
                },
                onSaved: (val) => data.distance = double.parse(val.replaceAll(',', '.')),
              ),
              new TextFormField(
                decoration: new InputDecoration(labelText: 'Cost (in Euros)'),
                validator: (val){
                  try {
                    var temp = double.parse(val.replaceAll(',', '.'));
                    return temp < 0.0 ? 'Not a positive number' : null;
                  } catch(e){
                    return 'Not a double.';
                  }
                },
                onSaved: (val) => data.cost = double.parse(val.replaceAll(',', '.')),
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