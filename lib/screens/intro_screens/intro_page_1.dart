import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    ' sehingga hanya dapat digunakan sekali, kemudian data akan hilang begitu aplikasi dibersihkan. \n\n Mohon diperhatikan untuk memiliki '),
            TextSpan(
              text: 'Printer Thermal',
              style: const TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.deepPurple,
              ),
            ),
            TextSpan(text: ' untuk menggunakan Aplikasi ini.'),
          ],
        ),
      ),
    );
  }
}
