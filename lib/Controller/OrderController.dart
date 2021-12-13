import 'dart:convert';
import 'package:flutter01/Model/Category.dart';
import 'package:flutter01/Model/Order.dart';
import 'package:flutter01/Model/OrderItem.dart';
import 'package:flutter01/Screens/CartPage/CartItem.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'OrderItemsController.dart';

abstract class OrderController{
  static Future<dynamic> GetAllOrdersOfUser() async{
    print("getting all orders of the user");
    SharedPreferences shared_prefs = await SharedPreferences.getInstance();
    var api_token = shared_prefs.get('user_api_token');
    print("user_api_token: ${api_token}");
    var user_id = shared_prefs.get('user_id');
    print("user_id: ${user_id}");
    var response = await http.get("http://mahmouddev.eyad-web-development.com/api/orders/${user_id}/?api_token=${api_token}");
    // var response = await http.get("http://10.0.2.2:8012/api/orders/${user_id}/?api_token=${api_token}");
    print("response status code: ${response.statusCode}");
    if(response.statusCode == 200){
      print("parsing JSON Data orders");
      List<Order> orders = <Order>[];
      //await _ParsingJSON(response).then((result) {orders = result;});
      //print("orders size: ${orders.length}");
      //return orders;

      print("we are parsing json");
      List<dynamic> list = json.decode(response.body);
      //print("getting orders response: ${response.body.toString()}");
      print("list size: ${list.length}");
      //List<Order> orders= <Order>[];
      for (int i = 0; i < list.length; i++){
        List<OrderItem> order_items= <OrderItem>[];
        await OrderItemController.GetAllOrderItemsOfOrder(list[i]['id'].toInt()).then((result) {order_items = result;});
        var order = Order(
          id: list[i]['id'].toInt(),
          user_id: list[i]['user_id'].toInt(),
          status: list[i]['status'].toInt(),
          total_price: list[i]['total_price'].toDouble(),
          order_items: order_items
        );
        print("before adding order items count: ${order.order_items.length}");
        orders.add(order);
      }
      return orders;
    }
    else {
      print("unexpected error while getting the products");
      return null;
    }
  }

  static Future<bool> PostOneOrdersOfUser({double total_price, List<CartItem> cart_items}) async{
    print("post one order of the user");
    SharedPreferences shared_prefs = await SharedPreferences.getInstance();
    var api_token = shared_prefs.get('user_api_token');
    //print("user_api_token: ${api_token}");
    var user_id = shared_prefs.get('user_id');
    //print("user_id: ${user_id}");
    var response = await http.post("http://mahmouddev.eyad-web-development.com/api/orders?api_token=${api_token}",
      body: {
        'user_id' : user_id.toString(),
        'status' : 0.toString(),
        'total_price': total_price.toString(),
      }
    );
    // var response = await http.post("http://10.0.2.2:8012/api/orders?api_token=${api_token}",
    //     body: {
    //       'user_id' : user_id.toString(),
    //       'status' : 0.toString(),
    //       'total_price': total_price.toString(),
    //     }
    // );
    print("response status code: ${response.statusCode}");
    if(response.statusCode == 200){
      print("parsing JSON Data post order");
      print("coming order orders response: ${response.body.toString()}");
      Map<String, dynamic> map = json.decode(response.body);
      int order_id = map['id'].toInt();
      print("order id: ${order_id}");
      cart_items.forEach((element) async {
        var order_item = OrderItem(
          order_id: order_id,
          product_id: element.product.id.toInt(),
          item_price: element.product.price.toDouble(),
          item_quantity: element.count.toInt(),
          item_total_price: (element.count * element.product.price).toDouble()
        );
        await OrderItemController.PostOneItemOfOrder(order_id: order_id, order_item: order_item)
          .then((value){
            if(value) {
              print("one order Item was post");
            }
          });
      });
      return true;
    }
    else {
      print("unexpected error while getting the products");
      return false;
    }
  }

  static Future<List<Order>> _ParsingJSON(dynamic response) async{
    print("we are parsing json");
    List<dynamic> list = json.decode(response.body);
    //print("getting orders response: ${response.body.toString()}");
    //print("list size: ${list.length}");
    List<Order> orders= <Order>[];
    for (int i = 0; i < list.length; i++){
      List<OrderItem> order_items= <OrderItem>[];
      await OrderItemController.GetAllOrderItemsOfOrder(list[i]['id'].toInt()).then((result) {order_items = result;});
      var order = Order(
          id: list[i]['id'].toInt(),
          user_id: list[i]['user_id'].toInt(),
          status: list[i]['status'].toInt(),
          total_price: list[i]['total_price'].toDouble(),
          //order_items: order_items
      );
      print("before adding order items count: ${order.order_items.length}");
      orders.add(order);
    }
    return orders;
  }

}