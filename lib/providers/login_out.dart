import 'package:flutter/material.dart';

class LogInOut with ChangeNotifier {
  TextEditingController shopNameController = TextEditingController();
  TextEditingController addressShopController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String shopName = '';
  String addressShop = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  bool isLoggedIn = false;

  void submitFirstData(BuildContext context) {
    shopName = shopNameController.text;
    addressShop = addressShopController.text;
    email = emailController.text;
    password = passwordController.text;
    confirmPassword = confirmPasswordController.text;
    notifyListeners();
  }

  void submitNewData(BuildContext context) {
    shopName = shopNameController.text;
    addressShop = addressShopController.text;
    email = emailController.text;
    password = passwordController.text;
    notifyListeners();
  }
}
