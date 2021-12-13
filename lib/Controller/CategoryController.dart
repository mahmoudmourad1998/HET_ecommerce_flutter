import 'dart:convert';
import 'package:flutter01/Model/Category.dart';
import 'package:flutter01/Model/Product.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class CategoryController{
  static Future<dynamic> GetAllCategories() async{
    print("getting products all categories");
    SharedPreferences shared_prefs = await SharedPreferences.getInstance();
    var api_token = shared_prefs.get('user_api_token');
    var response = await http.get("http://mahmouddev.eyad-web-development.com/api/categories/?api_token=${api_token}");
    // var response = await http.get("http://10.0.2.2:8012/api/categories/?api_token=${api_token}");
    print("response status code: ${response.statusCode}");
    if(response.statusCode == 200){
      print("parsing JSON Data");
      List<Category> categories = _ParsingJSON(response);
      return categories;
    }
    else {
      print("unexpected error while getting the products");
      return null;
    }
  }

  static List<Category> _ParsingJSON(dynamic response){
    List<dynamic> list = json.decode(response.body);
    List<Category> categories= <Category>[];
    list.forEach((element) {
      var category = Category(
        id: element['id'],
        title: element['title'],
      );
      categories.add(category);
      //print(product.toString());
    });
    return categories;
  }
}