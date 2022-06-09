import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/main_drawer.dart';
import '../widgets/unlogin_drawer.dart';
import '../providers/login_out.dart';

class About extends StatelessWidget {
  static const routeName = '/about';
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
    final login = Provider.of<LogInOut>(context, listen: false);
    return Scaffold(
      key: _globalKey,
      drawer: login.isLoggedIn ? MainDrawer() : UnLoginDrawer(),
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
                  },
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.center,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: 'Kasir Q',
                    style: const TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepPurple,
                    ),
                  ),
                  TextSpan(
                    text:
                        ' merupakan aplikasi Penjualan sederhana, simpel, dan mudah digunakan untuk kebutuhan anda. \n\nMembantu anda lebih efisien dalam usaha dan memberikan ',
                  ),
                  TextSpan(
                    text: 'Laporan Penjualan',
                    style: const TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepPurple,
                    ),
                  ),
                  TextSpan(
                      text:
                          ' berdasarkan pilihan tanggal. \n\n Aplikasi ini merupakan '),
                  TextSpan(
                    text: 'Trial',
                    style: const TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepPurple,
                    ),
                  ),
                  TextSpan(
                      text:
                          ' sehingga hanya dapat digunakan sekali, kemudian data akan hilang begitu aplikasi dibersihkan.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
