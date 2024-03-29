import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:revan_app/api/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:revan_app/screens/home.dart';

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    //widget state
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  var email, password;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Container(
                padding:
                    EdgeInsets.only(left: 28, right: 28, top: 28, bottom: 28),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 30),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child:
                                  Image.asset('assets/images/REVAN-logo.png'),
                            ),
                            width: MediaQuery.of(context).size.width / 4)
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 40),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 8),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Your Email",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.8,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                  TextFormField(
                                      decoration: InputDecoration(
                                        fillColor: HexColor("#F3F6F9"),
                                        labelStyle: TextStyle(
                                            color: HexColor("#3F4254")),
                                        filled: true,
                                        hintText: 'your@email.com',
                                        hintStyle: TextStyle(
                                            color: HexColor("#b5b5c2"),
                                            fontSize: 16),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                            borderSide: BorderSide.none),
                                      ),
                                      validator: (String? value) {
                                        if (value != null && value.isEmpty) {
                                          return 'Please enter your email';
                                        }
                                        email = value;
                                        return null;
                                      })
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 8, top: 25),
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 8),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Your Password",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.8,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                  TextFormField(
                                      obscureText: _secureText,
                                      decoration: InputDecoration(
                                        fillColor: HexColor("#F3F6F9"),
                                        labelStyle: TextStyle(
                                            color: HexColor("#3F4254")),
                                        filled: true,
                                        hintText: '●●●●●',
                                        suffixIcon: IconButton(
                                          onPressed: showHide,
                                          icon: Icon(_secureText
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                        ),
                                        hintStyle: TextStyle(
                                            color: HexColor("#b5b5c2"),
                                            fontSize: 16),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                            borderSide: BorderSide.none),
                                      ),
                                      validator: (String? value) {
                                        if (value != null && value.isEmpty) {
                                          return 'Please enter your password';
                                        }
                                        password = value;
                                        return null;
                                      })
                                ],
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(bottom: 8, top: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                        child: ElevatedButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          _login();
                                        }
                                      },
                                      child: Text(
                                        "Sign In",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      style: TextButton.styleFrom(
                                          backgroundColor: HexColor("#3699FF"),
                                          padding: EdgeInsets.only(
                                              top: 15,
                                              bottom: 15,
                                              left: 25,
                                              right: 25),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0))),
                                    )),
                                    Container(
                                      child: TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            'Forgot Password?',
                                            style: TextStyle(
                                                color: HexColor("#3F4254")),
                                          )),
                                    ),
                                  ],
                                ))
                          ],
                        )),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void _login() async {
    var data = {'email': email, 'password': password};
    var res = await Auth().login(data, '/login');
    var body = jsonDecode(res.body);

    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['authorization']['token']);
      localStorage.setString('user', json.encode(body['user']));

      Navigator.pushReplacement(
        context,
        new MaterialPageRoute(builder: (context) => Home()),
      );
    } else {
      Fluttertoast.showToast(
          msg: body['message'],
          backgroundColor: HexColor("#E55B64"),
          textColor: Colors.white);
    }
  }
}
