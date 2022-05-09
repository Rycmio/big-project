import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';
import '../providers/product.dart';
import '../providers/products.dart';
import '../utils/category_enum.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = 'edit-product';
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _dropDownController = TextEditingController();
  final _form = GlobalKey<FormState>();
  File? _pickedImage;
  String? _valueMenu;
  var _editedProduct = Product(
    id: null,
    name: '',
    image: null,
    price: 0,
    category: null,
  );
  final jenisMenu = [
    'Makanan',
    'Minuman',
    'Dessert',
  ];

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _saveData() {
    print('its work');
    Category _category = Category.Food;
    if (_dropDownController.text == 'Makanan') {
      _category = Category.Food;
    } else if (_dropDownController.text == 'Minuman') {
      _category = Category.Drinks;
    } else if (_dropDownController.text == 'Dessert') {
      _category = Category.Dessert;
    }
    _form.currentState!.save();
    Provider.of<Products>(context, listen: false).addProduct(
      _editedProduct,
      _category,
      _pickedImage!,
    );
    Navigator.of(context).pop();
  }

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
              onPressed: _saveData,
              icon: Icon(
                Icons.save,
                color: Colors.black87,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              ImageInput(
                onSelectImage: _selectImage,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nama Menu',
                  hintText: 'Masukkan Nama Menu',
                ),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    image: _editedProduct.image,
                    name: value,
                    price: _editedProduct.price,
                    category: _editedProduct.category,
                  );
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Harga',
                  hintText: 'Masukkan Harga Menu',
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    image: _editedProduct.image,
                    name: _editedProduct.name,
                    price: double.parse(value!),
                    category: _editedProduct.category,
                  );
                },
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
                controller: _dropDownController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
