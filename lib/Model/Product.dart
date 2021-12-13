import 'package:flutter/material.dart';

class Product {
  final int id;
  final String name;
  final String image_url;
  final int category_id ;
  final String description;
  final double price;
  final int stock;
  final double review;

  Product({
    this.id,
    this.name,
    this.image_url,
    this.category_id,
    this.description,
    this.price,
    this.stock,
    this.review
  }){
    //print('new product was created');
  }

  @override
  String toString() {
    return "product {id: ${this.id}, name: ${this.name}, image url: ${this.image_url}, category id: ${this.category_id}, description: ${this.description}, price: ${this.price}, stock: ${this.stock}, review: ${this.review},}";
  }
}

