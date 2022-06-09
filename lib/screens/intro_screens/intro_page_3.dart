import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/login_out.dart';

class IntroPage3 extends StatefulWidget {
  const IntroPage3({Key? key}) : super(key: key);

  @override
  State<IntroPage3> createState() => _IntroPage3State();
}

class _IntroPage3State extends State<IntroPage3> {
  bool _isObscure = true;
  bool _isObscureConfirm = true;
  final _confirmFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  @override
  void dispose() {
    _confirmFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final getController = Provider.of<LogInOut>(context, listen: false);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 170,
        ),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                  children: [
                    TextSpan(
                      text: 'Membuat akun owner.',
                      style: const TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple,
                      ),
                    ),
                    TextSpan(
                      text:
                          '\nAkun owner digunakan untuk mengakses bagian penting seperti Bagian Laporan dan Bagian Mengelola Menu yang akan dijual.',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Container(
                width: double.infinity,
                child: TextFormField(
                  controller: getController.emailController,
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
                  controller: getController.passwordController,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_confirmFocusNode);
                  },
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
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: TextFormField(
                  controller: getController.confirmPasswordController,
                  focusNode: _confirmFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Konfirmasi Password',
                    hintText: 'Masukkan Password Kembali',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscureConfirm = !_isObscureConfirm;
                        });
                      },
                      icon: Icon(
                        _isObscureConfirm
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                  obscureText: _isObscureConfirm,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Konfirmasi password tidak boleh kosong!';
                    }
                    if (value.length < 5) {
                      return 'Konfirmasi password setidaknya harus 5 karakter';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
