import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:revan_app/screens/login.dart';
import 'package:revan_app/screens/home.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    //widget state
    return ProfileState();
  }
}

class ProfileState extends State<Profile> {
  String? _name;
  String? _email;

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
      _email = decoded['email'];
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
                  margin: EdgeInsets.only(left: 50, top: 17),
                  child: Text(
                    "My Profile",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ])
            ])),
        body: SingleChildScrollView(
            child: Column(children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, top: 5),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      icon: Icon(
                        Icons.account_circle,
                        size: 40,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Profile()));
                      }),
                ),
              ),
              Column(children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${_name}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ]),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                Container(
                  height: 50,
                  color: Colors.amber[600],
                  child: const Center(child: Text('Entry A')),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[500],
                  child: const Center(child: Text('Entry B')),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[100],
                  child: const Center(child: Text('Entry C')),
                ),
              ],
            ),
          )
          // SizedBox(
          //   height: 10,
          // ),
        ])));
  }
}
