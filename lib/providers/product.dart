import 'dart:io';

import 'package:flutter/material.dart';
import '../utils/category_enum.dart';

class Product with ChangeNotifier {
  final String? id;
  final File? image;
  final String? name;
  final int price;
  bool status;
  final Category? category;

  Product({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    this.status = true,
    required this.category,
  });
}
