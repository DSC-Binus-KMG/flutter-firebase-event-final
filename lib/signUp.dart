import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mynewflutterapp/home.dart';
import 'package:mynewflutterapp/signin.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Builder(
        builder: (context) => Center(
          child: Form(
            key: _formKey,
            child: Container(
              width: 200.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.network(
                    'https://raw.githubusercontent.com/DSC-Binus-KMG-2019/flutter-firebase-event-test-repo/master/android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png',
                    width: 100.0,
                    height: 100.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0
                    ),
                    validator: (val){
                      if(val.isEmpty){
                          return 'Please type an email';
                      }
                    },
                    onSaved: (val) {
                      _email = val;
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Colors.blue,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0
                    ),
                    validator: (val){
                      if(val.isEmpty){
                          return 'Password cannot be empty';
                      }
                    },
                    onSaved: (val) {
                      _password = val;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Colors.blue,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  RaisedButton(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.blue,
                    onPressed: () => signUp(context),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  new InkWell(
                    child: new Text(
                      "Have an account? Sign In",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    onTap: (){
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => SignInPage()),
                      );
                    }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signUp(BuildContext context) async{
    final formState = _formKey.currentState;

    if(formState.validate()){
      formState.save();
      try{
        AuthResult authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage()
          )
        );
        viewSnackBar(context, "Sign Up Succesful");
      }
      catch(signUpError){
        if(signUpError is PlatformException) {
          if(signUpError.code == 'ERROR_INVALID_EMAIL') {
            viewSnackBar(context, "Sign Up Failed: Invalid Email!");
          }
          else if(signUpError.code == 'ERROR_WEAK_PASSWORD'){
            viewSnackBar(context, "Sign Up Failed: Password is too weak");
          }
          else {
            viewSnackBar(context, signUpError.code);
          }
        }
      }
    }
  }

  void viewSnackBar(BuildContext context, String text){
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text('${text}'),
      ),
    );
  }
}
