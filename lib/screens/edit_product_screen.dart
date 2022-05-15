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
  GlobalKey<ScaffoldMessengerState> contextKey =
      GlobalKey<ScaffoldMessengerState>();
  File? _pickedImage;
  String? _valueMenu;
  var _isInit = true;
  var _initValues = {
    'name': '',
    'price': '',
    'image': null,
    'category': null,
  };
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

  @override
  void didChangeDependencies() {
    if (_isInit) {
      if (ModalRoute.of(context)!.settings.arguments != null) {
        final productId = ModalRoute.of(context)?.settings.arguments as String;
        if (productId.isNotEmpty) {
          final product =
              Provider.of<Products>(context, listen: false).findById(productId);
          _editedProduct = product;

          _initValues = {
            'name': _editedProduct.name,
            'price': _editedProduct.price.toString(),
            'image': _editedProduct.image!.path,
            'category': null,
          };

          _dropDownController.text = _editedProduct.category.toString();
          if (_editedProduct.category.toString() == 'Category.Food') {
            _dropDownController.text = 'Makanan';
          } else if (_editedProduct.category.toString() == 'Category.Drinks') {
            _dropDownController.text = 'Minuman';
          } else if (_editedProduct.category.toString() == 'Category.Dessert') {
            _dropDownController.text = 'Dessert';
          }
        }
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _dropDownController.dispose();
    super.dispose();
  }

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _saveData() {
    Category _category = Category.Food;
    if (_dropDownController.text == 'Makanan') {
      _category = Category.Food;
    } else if (_dropDownController.text == 'Minuman') {
      _category = Category.Drinks;
    } else if (_dropDownController.text == 'Dessert') {
      _category = Category.Dessert;
    }
    final isValid = _form.currentState!.validate();
    if (!isValid || _dropDownController.text.isEmpty || _pickedImage == null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Mohon untuk mengisi seluruh data dengan tepat!',
            style: TextStyle(color: Colors.redAccent),
          ),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    _form.currentState!.save();
    if (_editedProduct.id != null) {
      Provider.of<Products>(context, listen: false).updateProduct(
          _editedProduct.id, _editedProduct, _category, _pickedImage!);
    } else {
      Provider.of<Products>(context, listen: false).addProduct(
        _editedProduct,
        _category,
        _pickedImage!,
      );
    }
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
                initialValue: _initValues['name'],
                decoration: InputDecoration(
                  labelText: 'Nama Menu',
                  hintText: 'Masukkan Nama Menu',
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama Menu Tidak Boleh Kosong!';
                  }
                  return null;
                },
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
                initialValue: _initValues['price'],
                decoration: InputDecoration(
                  labelText: 'Harga',
                  hintText: 'Masukkan Harga Menu',
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Harga Tidak Boleh Kosong!';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Harga Tidak Boleh Memiliki Huruf!';
                  }
                  if (double.parse(value) < 500) {
                    return 'Silahkan Masukkan Harga Diatas 500 Rupiah!';
                  }
                  return null;
                },
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
