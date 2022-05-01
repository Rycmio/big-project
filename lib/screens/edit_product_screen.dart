import 'package:flutter/material.dart';
import 'package:dropdownfield2/dropdownfield2.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = 'edit-product';
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  String? _valueMenu;
  final jenisMenu = [
    'Makanan',
    'Minuman',
    'Dessert',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black54,
        ),
        title: Text(
          'Edit Produk',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.save,
                color: Colors.black87,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nama Menu',
                  hintText: 'Masukkan Nama Menu',
                ),
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Harga',
                  hintText: 'Masukkan Harga Menu',
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              DropDownField(
                labelText: 'Jenis Menu',
                labelStyle: TextStyle(color: Colors.black, fontSize: 16),
                hintText: 'Pilih Jenis Menu',
                value: _valueMenu,
                setter: (value) {
                  setState(() {
                    _valueMenu = value;
                  });
                },
                items: jenisMenu,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    margin: const EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: Center(
                      child: Text('Tidak ada gambar'),
                    ),
                  ),
                  Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.add_photo_alternate),
                    label: Text('Tambah Gambar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
