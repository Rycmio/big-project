import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/main_drawer.dart';
import '../providers/products.dart';
import '../widgets/manage_product_item.dart';
import 'edit_product_screen.dart';

class ManageProductScreen extends StatelessWidget {
  static const routeName = "manage-product";

  const ManageProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context).items;
    GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _globalKey,
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 10,
              top: 40,
            ),
            child: Row(
              children: [
                IconButton(
                    icon: Icon(
                      Icons.menu,
                      size: 30,
                    ),
                    color: Colors.black54,
                    onPressed: () {
                      _globalKey.currentState!.openDrawer();
                    }),
                Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(EditProductScreen.routeName);
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
          Expanded(
            child: products.length <= 0
                ? Center(
                    child: Text('Tidak ada data'),
                  )
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    itemBuilder: (_, i) => Column(
                      children: [
                        ManageProductItem(
                          id: products[i].id,
                          name: products[i].name,
                          image: products[i].image,
                        ),
                        Divider(),
                      ],
                    ),
                    itemCount: products.length,
                  ),
          ),
        ],
      ),
    );
  }
}
