import 'dart:io';

import 'package:flutter/material.dart';

class ManageProductItem extends StatelessWidget {
  final String? name;
  final File? image;

  const ManageProductItem({
    Key? key,
    required this.name,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5, left: 5),
      child: ListTile(
        title: Text(name!),
        leading: CircleAvatar(
          backgroundImage: FileImage(image!),
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
