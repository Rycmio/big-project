import 'dart:io';

import 'package:flutter/material.dart';

import './product.dart';
import '../utils/category_enum.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'food1',
    //   imageUrl:
    //       'https://cdns.klimg.com/merdeka.com/i/w/news/2021/08/27/1345870/content_images/670x335/20210827142321-1-ilustrasi-bakso-009-tantri-setyorini.jpg',
    //   name: 'Bakso',
    //   price: 15000,
    //   status: true,
    //   category: Category.Food,
    // ),
    // Product(
    //   id: 'food2',
    //   imageUrl:
    //       'https://merahputih.com/media/7b/e2/24/7be2245ab4a3a5d334eefc1879d376d2.jpg',
    //   name: 'Es Jeruk Kecil',
    //   price: 5000,
    //   status: true,
    //   category: Category.Drinks,
    // ),
    // Product(
    //   id: 'food3',
    //   imageUrl:
    //       'https://awsimages.detik.net.id/customthumb/2015/01/10/297/132450_coverfatbubble2.jpg?w=700&q=90',
    //   name: 'Es Serut Matcha',
    //   price: 10000,
    //   status: true,
    //   category: Category.Dessert,
    // ),
  ];

  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  List<Product> filterProduct(Category category) {
    return _items.where((product) => category == product.category).toList();
  }

  void addProduct(Product product, Category category, File image) {
    final newProduct = Product(
      id: DateTime.now().toString(),
      image: image,
      name: product.name,
      price: product.price,
      category: category,
    );
    _items.add(newProduct);
    notifyListeners();
  }

  void updateProduct(
      String? id, Product product, Category category, File image) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = Product(
          id: id,
          image: image,
          name: product.name,
          price: product.price,
          category: category);
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future deleteProduct(String? id, BuildContext context) async {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Yakin akan dihapus?'),
        content: Text('Menu akan dihapus permanen!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _items.removeWhere((prod) => prod.id == id);
              notifyListeners();
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }
}
