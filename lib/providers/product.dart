import 'package:flutter/material.dart';

enum Category {
  Food,
  Drinks,
  Dessert,
}

class Product with ChangeNotifier {
  final String id;
  final String imageUrl;
  final String name;
  final double price;
  bool status;
  bool serve;
  final Category category;

  Product({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.price,
    this.status = true,
    this.serve = false,
    required this.category,
  });
}
