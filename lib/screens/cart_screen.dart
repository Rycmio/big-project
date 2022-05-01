import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/orders.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = 'cart-screen';
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black54,
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          'Pesanan',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: ListView(
          children: [
            SingleChildScrollView(
              child: Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height / 1.6,
                child: ListView.builder(
                  itemBuilder: (context, i) => CartItem(
                      id: cart.items.values.toList()[i].id,
                      productId: cart.items.keys.toList()[i],
                      price: cart.items.values.toList()[i].price,
                      quantity: cart.items.values.toList()[i].quantity,
                      name: cart.items.values.toList()[i].name),
                  itemCount: cart.items.length,
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Total Keseluruhan',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text('Rp ${cart.totalAmount}'),
                    ],
                  ),
                  SizedBox(height: 6),
                  Container(
                    width: double.maxFinite,
                    child: TextField(
                      decoration: InputDecoration(hintText: 'Total Dibayar'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(height: 6),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                        minimumSize: Size(double.infinity, 35)),
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                        cart.items.values.toList(),
                        cart.totalAmount,
                      );
                      cart.clear();
                    },
                    child: Text('Cetak Struk'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
