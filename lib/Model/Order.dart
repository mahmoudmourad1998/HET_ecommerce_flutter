import 'package:flutter/material.dart';
import 'package:flutter01/Model/OrderItem.dart';

class Order {
  final int id;
  final int user_id;
  final int status;
  final double total_price;
  final List<OrderItem> order_items;

  Order({
    this.id,
    this.user_id,
    this.status,
    this.total_price,
    this.order_items
  }){
    //print('new product was created');
  }

  @override
  String toString() {
    return "order {id: ${this.id}, user id: ${this.user_id}, status: ${this.status}, total price: ${this.total_price}, items: [${_PrintOrderItems()}]}";
  }

  String _PrintOrderItems() {
    String items = "";
    this.order_items.forEach((element) {
      String item = "{${element.toString()}}, ";
      items = items + item;
    });
    return items.toString();
  }
}

