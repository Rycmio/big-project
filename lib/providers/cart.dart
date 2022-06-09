import 'package:flutter/material.dart';

class CartItemData {
  final String id;
  final String name;
  final int price;
  final int quantity;

  CartItemData({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItemData> _items = {};

  Map<String, CartItemData> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(
    String? productId,
    String name,
    int price,
    int quantity,
  ) {
    if (_items.containsKey(productId)) {
      //tambahkan quantity
      _items.update(
        productId!,
        (existCart) => CartItemData(
          id: existCart.id,
          name: existCart.name,
          price: existCart.price,
          quantity: existCart.quantity + quantity,
        ),
      );
    } else {
      //tambah cart baru sesuai quantity
      _items.putIfAbsent(
        productId!,
        () => CartItemData(
          id: productId,
          name: name,
          price: price,
          quantity: quantity,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId, int quantity) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (existingCartItem) => CartItemData(
            id: existingCartItem.id,
            name: existingCartItem.name,
            price: existingCartItem.price,
            quantity: existingCartItem.quantity - quantity),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
