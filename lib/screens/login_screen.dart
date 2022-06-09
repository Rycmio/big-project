import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/login_out.dart';
import '../screens/category_meals_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true;
  final _form = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final login = Provider.of<LogInOut>(context, listen: false);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _form,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 35,
                  fontFamily: 'Quicsand',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 65),
              Container(
                width: double.infinity,
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    hintText: 'Masukkan E-mail',
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
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                child: TextFormField(
                  controller: _passwordController,
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
                        _isObscure ? Icons.visibility : Icons.visibility_off,
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
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (!_form.currentState!.validate()) return;
                  if (_emailController.text != login.email ||
                      _passwordController.text != login.password) {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('E-mail atau Password salah!'),
                        content:
                            Text('Masukkan email atau password dengan benar'),
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
                  } else {
                    Navigator.of(context)
                        .pushReplacementNamed(CategoryMealsScreen.routeName);
                    login.isLoggedIn = true;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Berhasil Login!'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 18),
                ),
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  minimumSize: Size(double.infinity, 40),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
