import 'package:flutter/material.dart';
import 'package:flutter01/Model/Product.dart';

class CartItem {
  final Product product;
  final int count;

  CartItem({
    this.product,
    this.count,
  }) {
    //print('new category was created');
  }

  @override
  String toString() {
    return "Cart Item {product: ${this.product}, count: ${this.count},}";
  }
}
