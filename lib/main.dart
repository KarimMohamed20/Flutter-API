import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:usersgo/home.dart';

void main() {
  runApp(new MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  )
    );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 10,
      navigateAfterSeconds: new HomePage(),
      image: Image.network("http://tonydowney.ca/wp-content/uploads/2017/05/14101776.jpg"),
      title: new Text("Hello World"),
      photoSize: 100.0,
    );
  }
}