import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
class AddUser extends StatefulWidget {
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final TextEditingController name = new TextEditingController();
  final TextEditingController email = new TextEditingController();

  void postNow() async {
    Dio dio = new Dio();
   Response apiResponse = await dio.post("http://192.168.1.2:8081/user/${name.text}/${email.text}");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Add User"),
      ),
      body: new Container(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new TextField(
              controller: name,
              decoration: new InputDecoration(
                hintText: 'Enter Your Name.'
              ),
            ),
            new TextField(
              controller: email,
              decoration: new InputDecoration(
                hintText: 'Enter Your Email.'
              ),
            ),
            new Padding(
              padding: EdgeInsets.all(50.0),
              child: new Image.network("http://tonydowney.ca/wp-content/uploads/2017/05/14101776.jpg"),
            ),
            new RaisedButton(
              onPressed: postNow,
              child: new Text("Add",
              style: new TextStyle(
                color: Colors.white
              )),
              color: Colors.blue,
              padding: EdgeInsets.all(15.0),
            )
          ],
        ),
      ),
    );
  }
}