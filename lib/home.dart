import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:usersgo/AddUser.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  List data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("http://192.168.1.2:8081/users"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = JSON.decode(response.body);
    });
    // print(data[1]["Email"]);

    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  Future<Null> refreshList() async {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Flutter Egypt"),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          new IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new AddUser())),
          ),
        ],
      ),
      body: RefreshIndicator(
        //   key: refreshKey,
        child: new ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return new ListTile(
                title: new Text(data[index]["Name"]),
                subtitle: new Text(data[index]["Email"]),
                leading: new CircleAvatar(
                  child: new Text(
                    data[index]["Name"][0],
                    style: new TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.red,
                ),
                trailing: InkWell(
                  child: new Icon(Icons.not_interested,color: Colors.red,),
                  onTap: () async {
                     Dio dio = new Dio();
                     Response response = await dio.delete("http://192.168.1.2:8081/user/" + data[index]["Name"]);
                     print("Deleted: ${data[index]["Name"]}");
                     print("response:" + response.statusCode.toString());
                    }, 
                  ),
                    
                    
            );
          },
        ),
        onRefresh: refreshList,
      ),
    );
  }
}
