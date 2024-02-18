import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:revan_app/screens/login.dart';
import 'package:revan_app/screens/profile.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    //widget state
    return HomeState();
  }
}

class HomeState extends State<Home> {
  String? _name;

  @override
  void initState() {
    super.initState();
    _getName();
  }

  void _getName() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    setState(() {
      String? user = localStorage.getString('user');
      var decoded = jsonDecode(user ?? '');
      _name = decoded['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 60,
        scrolledUnderElevation: 0,
        flexibleSpace: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).viewPadding.top,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              child: IconButton(
                  icon: Icon(
                    Icons.menu,
                    size: 25,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // Scaffold.of(context).openDrawer();
                  }),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                "Home",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10),
              child: IconButton(
                  icon: Icon(
                    Icons.account_circle,
                    size: 35,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                  }),
            )
          ])
        ]),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Welcome,",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${_name} 👋🏻",
                  style: TextStyle(color: HexColor("#3F4254"), fontSize: 17),
                )),
          ),
          SizedBox(
            height: 15,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
                margin: EdgeInsets.only(left: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, top: 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Expenses',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, bottom: 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Rp. 15.000.000',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: HexColor("#F64E60"),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ]),
                )),
            Container(
                margin: EdgeInsets.only(right: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, top: 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Incomes',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, bottom: 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Rp. 20.000.000',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: HexColor("#1BC5BD"),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ]),
                ))
          ])
        ]),
      ),
    );
  }
}
