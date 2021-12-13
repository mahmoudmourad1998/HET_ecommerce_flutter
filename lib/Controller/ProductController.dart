import 'dart:convert';
import 'package:flutter01/Model/Product.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductController{
  static Future<dynamic> GetAllProductsWithCategory({int category_id}) async{
    print("getting products of category number: ${category_id}");
    SharedPreferences shared_prefs = await SharedPreferences.getInstance();
    var api_token = shared_prefs.get('user_api_token');
    var response = await http.get("http://mahmouddev.eyad-web-development.com/api/productsOfCategory/${category_id}/?api_token=${api_token}");
    //var response = await http.get("http://10.0.2.2:8012/api/productsOfCategory/${category_id}/?api_token=${api_token}");
    print("response status code: ${response.statusCode}");
    if(response.statusCode == 200){
      print("parsing JSON Data");
      List<Product> products = _ParsingJSON(response);
      print("products count of this category: ${products.length}");
      return products;
    }
    else {
      print("unexpected error while getting the products");
      return null;
    }
  }

  static List<Product> _ParsingJSON(dynamic response){
    List<dynamic> list = json.decode(response.body);
    List<Product> products= <Product>[];
    list.forEach((element) {
      var product = Product(
        id: element['id'].toInt(),
        name: element['name'].toString(),
        image_url: element['image_url'].toString(),
        category_id: element['category_id'].toInt(),
        description: element['description'].toString(),
        price: element['price'].toDouble(),
        stock: element['stock'].toInt(),
        review: element['review'].toDouble(),
      );
      products.add(product);
      //print(product.toString());
    });
    return products;
  }
}