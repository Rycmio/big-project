import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/main_drawer.dart';
import '../widgets/unlogin_drawer.dart';
import '../providers/login_out.dart';

class ShopInfo extends StatefulWidget {
  static const routeName = '/shop-info';
  const ShopInfo({Key? key}) : super(key: key);

  @override
  State<ShopInfo> createState() => _ShopInfoState();
}

class _ShopInfoState extends State<ShopInfo> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
    var _isLoggedIn = Provider.of<LogInOut>(context);
    return Scaffold(
      key: _globalKey,
      drawer: _isLoggedIn.isLoggedIn ? MainDrawer() : UnLoginDrawer(),
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
                  onPressed: () async {
                    if (_isLoggedIn.shopNameController.text.isEmpty ||
                        _isLoggedIn.addressShopController.text.isEmpty ||
                        _isLoggedIn.passwordController.text.isEmpty ||
                        _isLoggedIn.confirmPasswordController.text.isEmpty ||
                        _isLoggedIn.emailController.text.isEmpty) {
                      return showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('Data tidak valid'),
                          content:
                              Text('Mohon isi semua data yang diperlukan!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: Text('Oke'),
                            ),
                          ],
                        ),
                      );
                    }
                    if (RegExp(r'\s')
                        .hasMatch(_isLoggedIn.emailController.text)) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Email tidak boleh memiliki spasi!',
                            style: TextStyle(color: Colors.redAccent),
                          ),
                          duration: Duration(seconds: 1),
                        ),
                      );
                      return;
                    }
                    if (_isLoggedIn.confirmPasswordController.text.length < 5 ||
                        _isLoggedIn.passwordController.text.length < 5) {
                      return;
                    }
                    _isLoggedIn.submitNewData(context);
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Data Toko berhasil diubah!'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  icon: Icon(Icons.save),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                        children: [
                          TextSpan(
                            text: 'Informasi Toko',
                            style: const TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.deepPurple,
                            ),
                          ),
                          TextSpan(
                            text: '\nEdit data Toko anda.',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Akun Owner',
                      style: const TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      child: TextFormField(
                        controller: _isLoggedIn.emailController,
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          hintText: 'Masukkan E-mail anda',
                          suffixIcon: Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email tidak boleh kosong!';
                          }
                          if (!value.endsWith('@gmail.com')) {
                            return 'Email harus diakhiri @gmail.com';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      child: TextFormField(
                        controller: _isLoggedIn.passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Masukkan Password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                        obscureText: _isObscure,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password tidak boleh kosong!';
                          }
                          if (value.length < 5) {
                            return 'Password setidaknya harus 5 karakter';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                    Text(
                      'Data Toko',
                      style: const TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      child: TextFormField(
                        controller: _isLoggedIn.shopNameController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Nama Toko',
                          hintText: 'Masukkan nama toko',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Nama Toko tidak boleh kosong!';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      child: TextFormField(
                        controller: _isLoggedIn.addressShopController,
                        decoration: InputDecoration(
                          labelText: 'Alamat Toko',
                          hintText: 'Masukkan alamat toko',
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 2,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Alamat Toko tidak boleh kosong!';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
