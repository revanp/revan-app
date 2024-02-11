import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  // final String url = 'https://revanpratama.online/api/';
  // var token;

  // getToken() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();

  //   token = jsonDecode(localStorage.getString('token'))['token'];
  // }

  // login(data, apiURL) async {
  //   var fullUrl = url + apiURL;
  //   return await http.post(fullUrl,
  //       body: jsonEncode(data), headers: _setHeaders());
  // }

  // getData(apiURL) async {
  //   var fullUrl = url + apiURL;
  //   await getToken();
  //   return await http.get(
  //     fullUrl,
  //     headers: _setHeaders(),
  //   );
  // }

  // _setHeaders() => {
  //       'Content-type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     };
}
