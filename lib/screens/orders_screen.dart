import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/main_drawer.dart';
import '../widgets/order_item.dart';
import '../providers/orders.dart' show Orders;

class OrdersScreen extends StatelessWidget {
  static const routeName = 'order-screen';
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
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
                SizedBox(width: 10),
                Text(
                  'Laporan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: orderData.orders.length,
              itemBuilder: (ctx, i) => OrderItem(order: orderData.orders[i]),
            ),
          ),
        ],
      ),
    );
  }
}
