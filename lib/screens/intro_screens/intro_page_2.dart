import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/login_out.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _form = GlobalKey<FormState>();
    final getController = Provider.of<LogInOut>(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    text: 'Silahkan masukkan Nama Toko dan Alamat Toko anda.',
                    style: const TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepPurple,
                    ),
                  ),
                  TextSpan(
                    text:
                        '\nData ini diperlukan untuk keperluan cetak struk nantinya.',
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Container(
              width: double.infinity,
              child: TextFormField(
                controller: getController.shopNameController,
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
                controller: getController.addressShopController,
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
    );
  }
}
