import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mynewflutterapp/signin.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<SplashPage> {
  @override
  Widget build(BuildContext context){
    Future.delayed(Duration (seconds: 3)).then((_) async{
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SignInPage())
      );
    });
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: new Image.network(
              'https://raw.githubusercontent.com/DSC-Binus-KMG-2019/flutter-firebase-event-test-repo/master/android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png',
              width: 250.0,
              height: 250.0,
            )
          ),
        ]
      ),
      backgroundColor: Colors.blue,
    );
  }
}