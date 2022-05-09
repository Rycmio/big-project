import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../utils/category_enum.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  final Category categoryProduct;

  const ProductsGrid({
    Key? key,
    required this.categoryProduct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = Provider.of<Products>(context, listen: false)
        .filterProduct(categoryProduct);

    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: MediaQuery.of(context).size.width /
            MediaQuery.of(context).size.height /
            0.94,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: filter[i],
        child: ProductItem(
            // id: filter[i].id,
            // name: filter[i].name,
            // imageUrl: filter[i].imageUrl,
            // price: filter[i].price,
            // status: filter[i].status,
            ),
      ),
      itemCount: filter.length,
    );
  }
}
