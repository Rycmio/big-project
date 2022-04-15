import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  bool status;

  ProductItem({
    Key? key,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.status = true,
  }) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 6),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                child: Container(
                  height: 180,
                  width: 390,
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    height: 25,
                    color: Colors.black54,
                    child: Row(
                      children: [
                        Text(
                          'Ready',
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        ),
                        Switch(
                          value: widget.status,
                          onChanged: (newValue) {
                            widget.status = newValue;
                            setState(() {});
                          },
                          activeColor: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 5,
                child: Container(
                  width: 110,
                  color: Colors.black54,
                  padding: const EdgeInsets.all(3),
                  child: Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Colors.black12,
            child: Column(
              children: [
                Text('Rp ${widget.price}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.remove_circle),
                      iconSize: 25,
                    ),
                    Container(
                      width: 40,
                      height: 30,
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          '1',
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add_circle),
                      iconSize: 25,
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Add'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(30),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
