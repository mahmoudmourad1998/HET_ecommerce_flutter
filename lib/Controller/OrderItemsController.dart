import 'dart:convert';
import 'package:flutter01/Model/Category.dart';
import 'package:flutter01/Model/Order.dart';
import 'package:flutter01/Model/OrderItem.dart';
import 'package:flutter01/Model/Product.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class OrderItemController{
  static Future<dynamic> GetAllOrderItemsOfOrder(int order_id) async{
    print("getting all order items of the order: ${order_id}");
    //var user_id = "1";
    SharedPreferences shared_prefs = await SharedPreferences.getInstance();
    var api_token = shared_prefs.get('user_api_token');
    //var api_token = "m9yjA3qsq3iajNQumI9JgOtQpAfcJZyy4xknR8YYnWr4g9KxAQrT5ZbwTrKu87VulgSoZbR7BThr8P5KbMSvvcsOORHqm323xu18";
    var response = await http.get("http://mahmouddev.eyad-web-development.com/api/orderItems/${order_id.toString()}/?api_token=${api_token}");
    // var response = await http.get("http://10.0.2.2:8012/api/orderItems/${order_id.toString()}/?api_token=${api_token}");
    print("response status code: ${response.statusCode}");
    if(response.statusCode == 200){
      print("parsing JSON Data order item");
      List<OrderItem> order_items = _ParsingJSON(response);
      print("order: ${order_id} Items size: ${order_items.length}");
      print("returning from getting order items");
      return order_items;
    }
    else {
      print("unexpected error while getting the products");
      return null;
    }
  }

  static List<OrderItem> _ParsingJSON(dynamic response){
    List<dynamic> list = json.decode(response.body);
    print(response.body.toString());
    List<OrderItem> order_items= <OrderItem>[];
    list.forEach((element) {
      var order_item = OrderItem(
          order_id: element['order_id'].toInt(),
          product_id: element['product_id'].toInt(),
          item_price: element['item_price'].toDouble(),
          item_quantity: element['item_quantity'].toInt(),
          item_total_price: element['item_total_price'].toDouble()
      );
      //print("orderItem: ${order_item.toString()}");
      order_items.add(order_item);
    });
    return order_items;
  }

  static Future<bool> PostOneItemOfOrder({int order_id, OrderItem order_item}) async{
    print("post one Item of the order: ${order_id}");
    SharedPreferences shared_prefs = await SharedPreferences.getInstance();
    var api_token = shared_prefs.get('user_api_token');
    //print("user_api_token: ${api_token}");
    var response = await http.post("http://mahmouddev.eyad-web-development.com/api/orderItems?api_token=${api_token}",
        body: {
          'order_id' : order_id.toString(),
          'product_id' : order_item.product_id.toString(),
          'item_price': order_item.item_price.toString(),
          'item_quantity': order_item.item_quantity.toString(),
          'item_total_price': order_item.item_total_price.toString(),
        }
    );
    // var response = await http.post("http://10.0.2.2:8012/api/orderItems?api_token=${api_token}",
    //     body: {
    //       'order_id' : order_id.toString(),
    //       'product_id' : order_item.product_id.toString(),
    //       'item_price': order_item.item_price.toString(),
    //       'item_quantity': order_item.item_quantity.toString(),
    //       'item_total_price': order_item.item_total_price.toString(),
    //     }
    // );
    print("response status code: ${response.statusCode}");
    if(response.statusCode == 200){
      print("parsing JSON Data post order Item for order: ${order_id}");
      print("order item post response: ${response.body.toString()}");
      return true;
    }
    else {
      print("unexpected error while getting the products");
      return false;
    }
  }

}