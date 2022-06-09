import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/category_meals_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/manage_product_screen.dart';
import '../screens/edit_product_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/login_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/about.dart';
import '../screens/shop_info.dart';
import '../utils/inputTheme.dart';
import '../providers/products.dart';
import '../providers/cart.dart';
import '../providers/orders.dart';
import '../providers/login_out.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => LogInOut(),
        ),
      ],
      child: MaterialApp(
        title: 'KasirQ',
        theme: ThemeData(
          canvasColor: Color(0xFFF1F2F3),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
              .copyWith(secondary: Colors.deepOrange),
          fontFamily: 'Lato',
          inputDecorationTheme: InputTheme().theme(),
        ),
        home: SplashScreen(),
        routes: {
          CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          ManageProductScreen.routeName: (ctx) => ManageProductScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          SplashScreen.routeName: (ctx) => SplashScreen(),
          OnBoardingScreen.routeName: (ctx) => OnBoardingScreen(),
          About.routeName: (ctx) => About(),
          ShopInfo.routeName: (ctx) => ShopInfo(),
        },
      ),
    );
  }
}
