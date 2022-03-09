import 'package:flutter/material.dart';

import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView(
        padding: const EdgeInsets.all(10),
        children: [
          CategoryItem(id: 'food', title: 'MAKANAN'),
          CategoryItem(id: 'drink', title: 'MINUMAN'),
          CategoryItem(id: 'desert', title: 'DESERT'),
        ],
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
