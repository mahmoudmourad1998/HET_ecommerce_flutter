import 'dart:convert';
import 'package:flutter01/Model/Category.dart';
import 'package:flutter01/Model/Product.dart';
import 'package:http/http.dart' as http;

abstract class UserController{
  static Future<dynamic> LoginUser(Map<String, dynamic> credintials) async{
    print("logging user in");
    var response = await http.post(
      "http://mahmouddev.eyad-web-development.com/api/users/login",
       body: credintials,
    );
    // var response = await http.post(
    //   "http://10.0.2.2:8012/api/users/login",
    //   body: credintials,
    // );
    print("response status code: ${response.statusCode}");
    if(response.statusCode == 200){
      print("parsing JSON data user login");
      var user_data = _ParsingJsonLogin(response);
      return user_data;
    }
    else {
      print("unexpected error while getting the products");
      return null;
    }
  }

  static Future<dynamic> RegisterUser(Map<String, dynamic> credintials) async{
    print("register new user");
    print(credintials);
    var response = await http.post(
      "http://mahmouddev.eyad-web-development.com/api/users/register",
      body: credintials,
    );
    // var response = await http.post(
    //   "http://10.0.2.2:8012/api/users/register",
    //   body: credintials,
    // );
    print("response status code: ${response.statusCode}");
    if(response.statusCode == 200){
      print("parsing JSON data user register");
      var user_data = _ParsingJsonRegister(response);
      return user_data;
    }
    else {
      print("unexpected error while getting the products");
      return null;
    }
  }

  static Future<bool> LogOutUser() async{
    print("logging user out");
    //var api_token = "m9yjA3qsq3iajNQumI9JgOtQpAfcJZyy4xknR8YYnWr4g9KxAQrT5ZbwTrKu87VulgSoZbR7BThr8P5KbMSvvcsOORHqm323xu18";
    var response = await http.get("http://mahmouddev.eyad-web-development.com/api/users/logout");
    // var response = await http.get("http://10.0.2.2:8012/api/users/logout");
    print("response status code: ${response.statusCode}");
    if(response.statusCode == 200){
      print("parsing JSON data user logout");
      var result = json.decode(response.body);
      print("user logout result: ${result}");
      return true;
    }
    else {
      print("unexpected error while getting the products");
      return false;
    }
  }

  static Map<String, dynamic> _ParsingJsonLogin(dynamic response){
    var data = json.decode(response.body);
    //print(data);
    Map<String, dynamic> user_data = <String, dynamic>{
      "user_id" : data['id'],
      "user_name" : data['name'],
      "user_email" : data['email'],
      "user_api_token" : data['api_token'],
      "user_ntf_token" : data['profile']['ntf_token'].toString(),
    };
    return user_data;
  }

  static Map<String, dynamic> _ParsingJsonRegister(dynamic response){
    var data = json.decode(response.body);
    Map<String, dynamic> user_data = <String, dynamic>{
      "user_id" : data['id'],
      "user_name" : data['name'],
      "user_email" : data['email'],
      "user_api_token" : data['api_token'],
      "user_ntf_token" : data['profile']['ntf_token'],
    };
    return user_data;
  }
}