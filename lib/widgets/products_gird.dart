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

    var _height = 0.0;
    if (MediaQuery.of(context).size.height > 678.0) {
      _height = 0.75;
    } else {
      _height = 0.94;
    }

    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: MediaQuery.of(context).size.width /
            MediaQuery.of(context).size.height /
            _height,
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
