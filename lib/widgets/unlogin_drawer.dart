import 'package:flutter/material.dart';

import '../screens/about.dart';
import '../screens/category_meals_screen.dart';

class UnLoginDrawer extends StatelessWidget {
  const UnLoginDrawer({Key? key}) : super(key: key);

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
