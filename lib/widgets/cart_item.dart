import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final int price;
  final int quantity;
  final String name;

  const CartItem({
    Key? key,
    required this.id,
    required this.productId,
    required this.price,
    required this.quantity,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatNumber = NumberFormat.simpleCurrency(
      decimalDigits: 0,
      locale: 'id_ID',
    );

    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Yakin akan dihapus?'),
            content: Text('Menghapus akan menghilangkan produk pada pesanan!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: Text('Yes'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(
                  child: Text(
                    formatNumber.format(price),
                  ),
                ),
              ),
            ),
            title: Text(name),
            subtitle: Text('Total: ${formatNumber.format(price) * quantity}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
