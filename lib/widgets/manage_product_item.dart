import 'package:flutter/material.dart';

class ManageProductItem extends StatelessWidget {
  final String nama;
  final String imageUrl;

  const ManageProductItem({
    Key? key,
    required this.nama,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5, left: 5),
      child: ListTile(
        title: Text(nama),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
