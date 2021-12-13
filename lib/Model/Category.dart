import 'package:flutter/material.dart';

class Category {
  final int id;
  final String title;

  Category({
    this.id,
    this.title,
  }) {
    //print('new category was created');
  }

  @override
  String toString() {
    return "category {id: ${this.id}, title: ${this.title},}";
  }
}
