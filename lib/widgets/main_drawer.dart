import 'package:flutter/material.dart';

import '../screens/manage_product_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/category_meals_screen.dart';
import '../screens/about.dart';
import '../screens/shop_info.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text(
              'KasirQ',
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w600,
              ),
            ),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.point_of_sale),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(CategoryMealsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Produk'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ManageProductScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.stacked_bar_chart),
            title: Text('Laporan'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.badge),
            title: Text('Informasi Toko'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(ShopInfo.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(About.routeName);
            },
          ),
        ],
      ),
    );
  }
}
