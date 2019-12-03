import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String _name = "";
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Builder(
        builder: (context)=>Form(
          key: _key,
          child: Center(
            child: Container(
              width: 200.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Put your name here!',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    onSaved: (val){
                      _name = val;
                    },
                  ),
                  SizedBox(height: 10.0),
                  FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text(
                      'Save Name',
                    ),
                    onPressed: (){
                      submitForm(context);
                    },
                  ),
                ],
              )
            )
          ),
        ),
      ),
    );
  }

  Widget _a(BuildContext context){
    
  }

  void viewSnackBar(BuildContext context){
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Hello, ' + _name),
      ),
    );
  }

  void submitForm(BuildContext context){
    final formState = _key.currentState;
    formState.save();
    viewSnackBar(context);
  }
}