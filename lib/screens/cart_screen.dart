import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';

import '../providers/cart.dart';
import '../providers/orders.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  static const routeName = 'cart-screen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<BluetoothDevice> devices = [];
  BluetoothDevice? selectedDevice;
  BlueThermalPrinter printer = BlueThermalPrinter.instance;
  TextEditingController _controller = TextEditingController();
  bool _connected = false;
  bool _bluetoothOff = false;
  bool _thermalOff = false;
  bool _errorThermal = false;

  @override
  void initState() {
    super.initState();
    getDevice();
    initPlatformState();
  }

  void getDevice() async {
    try {
      devices = await printer.getBondedDevices();
      print("getDevice : ${devices[0].name}");
      setState(() {});
    } on PlatformException {
      setState(() {
        _thermalOff = true;
      });
    }
  }

  Future<void> initPlatformState() async {
    printer.onStateChanged().listen((state) {
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          setState(() {
            _connected = true;
            _thermalOff = false;
            print("bluetooth device state: connected");
          });
          break;
        case BlueThermalPrinter.DISCONNECTED:
          setState(() {
            _connected = false;
            _thermalOff = true;
            print("bluetooth device state: disconnected");
          });
          break;
        case BlueThermalPrinter.DISCONNECT_REQUESTED:
          setState(() {
            _connected = false;
            print("bluetooth device state: disconnect requested");
          });
          break;
        case BlueThermalPrinter.STATE_TURNING_OFF:
          setState(() {
            _connected = false;
            print("bluetooth device state: bluetooth turning off");
          });
          break;
        case BlueThermalPrinter.STATE_OFF:
          setState(() {
            _connected = false;
            _bluetoothOff = true;
            print("bluetooth device state: bluetooth off");
          });
          break;
        case BlueThermalPrinter.STATE_ON:
          setState(() {
            _connected = false;
            _bluetoothOff = false;
            print("bluetooth device state: bluetooth on");
          });
          break;
        case BlueThermalPrinter.STATE_TURNING_ON:
          setState(() {
            _connected = false;
            print("bluetooth device state: bluetooth turning on");
          });
          break;
        case BlueThermalPrinter.ERROR:
          setState(() {
            _connected = false;
            _errorThermal = true;
            print("bluetooth device state: error");
          });
          break;
        default:
          print(state);
          break;
      }
    });
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final order = Provider.of<Orders>(context, listen: false);
    final formatNumber = NumberFormat.simpleCurrency(
      decimalDigits: 0,
      locale: 'id_ID',
    );
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black54,
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          'Pesanan',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: ListView(
          children: [
            SingleChildScrollView(
              child: Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height / 1.6,
                child: cart.items.length == 0
                    ? Center(
                        child: Text(
                          'Belum ada Pesanan!',
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemBuilder: (context, i) => CartItem(
                            id: cart.items.values.toList()[i].id,
                            productId: cart.items.keys.toList()[i],
                            price: cart.items.values.toList()[i].price,
                            quantity: cart.items.values.toList()[i].quantity,
                            name: cart.items.values.toList()[i].name),
                        itemCount: cart.items.length,
                      ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Total Keseluruhan',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(formatNumber.format(cart.totalAmount)),
                    ],
                  ),
                  SizedBox(height: 6),
                  Container(
                    width: double.maxFinite,
                    child: TextField(
                      decoration: InputDecoration(hintText: 'Total Dibayar'),
                      keyboardType: TextInputType.number,
                      controller: _controller,
                    ),
                  ),
                  SizedBox(height: 6),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                        minimumSize: Size(double.infinity, 35)),
                    onPressed: () async {
                      // if (!(await printer.isConnected)! &&
                      //     _connected == false) {
                      //   showModalBottomSheet(
                      //       context: context,
                      //       builder: (_) {
                      //         return Scaffold(
                      //           body: StatefulBuilder(
                      //             builder: (BuildContext context,
                      //                 StateSetter setModalState) {
                      //               return Padding(
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: Column(
                      //                   children: [
                      //                     const Text(
                      //                       'Printer tidak terkoneksi - koneksikan terlebih dahulu',
                      //                       style: TextStyle(
                      //                           fontWeight: FontWeight.bold),
                      //                     ),
                      //                     SizedBox(height: 10),
                      //                     DropdownButton<BluetoothDevice>(
                      //                       value: selectedDevice,
                      //                       hint: const Text('Pilih Printer'),
                      //                       onChanged: (device) {
                      //                         setModalState(() {
                      //                           selectedDevice = device;
                      //                         });
                      //                       },
                      //                       items: devices
                      //                           .map((e) => DropdownMenuItem(
                      //                                 child: Text(e.name!),
                      //                                 value: e,
                      //                               ))
                      //                           .toList(),
                      //                     ),
                      //                     SizedBox(height: 10),
                      //                     ElevatedButton(
                      //                         style: TextButton.styleFrom(
                      //                             minimumSize: Size(
                      //                                 double.infinity, 35)),
                      //                         onPressed: () {
                      //                           if (_thermalOff) {
                      //                             ScaffoldMessenger.of(context)
                      //                                 .hideCurrentSnackBar();
                      //                             ScaffoldMessenger.of(context)
                      //                                 .showSnackBar(
                      //                               SnackBar(
                      //                                 content: Text(
                      //                                   'Printer tidak menyala! - nyalakan terlebih dahulu!',
                      //                                   style: TextStyle(
                      //                                       color: Colors
                      //                                           .redAccent),
                      //                                 ),
                      //                                 duration:
                      //                                     Duration(seconds: 2),
                      //                               ),
                      //                             );
                      //                             return;
                      //                           }
                      //                           if (_bluetoothOff) {
                      //                             ScaffoldMessenger.of(context)
                      //                                 .hideCurrentSnackBar();
                      //                             ScaffoldMessenger.of(context)
                      //                                 .showSnackBar(
                      //                               SnackBar(
                      //                                 content: Text(
                      //                                   'Bluetooth tidak menyala!',
                      //                                   style: TextStyle(
                      //                                       color: Colors
                      //                                           .redAccent),
                      //                                 ),
                      //                                 duration:
                      //                                     Duration(seconds: 1),
                      //                               ),
                      //                             );
                      //                             return;
                      //                           }
                      //                           if (_errorThermal) {
                      //                             ScaffoldMessenger.of(context)
                      //                                 .hideCurrentSnackBar();
                      //                             ScaffoldMessenger.of(context)
                      //                                 .showSnackBar(
                      //                               SnackBar(
                      //                                 content: Text(
                      //                                   'Terjadi error pada printer!',
                      //                                   style: TextStyle(
                      //                                       color: Colors
                      //                                           .redAccent),
                      //                                 ),
                      //                                 duration:
                      //                                     Duration(seconds: 1),
                      //                               ),
                      //                             );
                      //                             return;
                      //                           }
                      //                           printer
                      //                               .connect(selectedDevice!);
                      //                           Navigator.of(context).pop();
                      //                         },
                      //                         child: const Text('Connect'))
                      //                   ],
                      //                 ),
                      //               );
                      //             },
                      //           ),
                      //         );
                      //       });
                      //   return;
                      // }
                      if (_controller.text.isEmpty) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Silahkan isi total bayar terlebih dahulu!',
                              style: TextStyle(color: Colors.redAccent),
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      }
                      if (int.parse(_controller.text) < cart.totalAmount) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Total bayar tidak cukup untuk membayar!',
                              style: TextStyle(color: Colors.redAccent),
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      }

                      if ((await printer.isConnected)!) {
                        printer.printNewLine();
                        printer.printCustom('TOKOKU', 3, 1);
                        printer.printNewLine();
                        printer.printCustom('TOKO ADDRESS LOCATION', 1, 1);
                        printer.printNewLine();
                        printer.printNewLine();
                        printer.printLeftRight('Tanggal',
                            DateFormat('dd/MM/yyyy').format(DateTime.now()), 1);
                        printer.printNewLine();
                        for (var value in cart.items.values) {
                          printer.printCustom(value.name, 0, 0);
                          printer.print4Column(
                            value.quantity.toString(),
                            'x',
                            formatNumber.format(value.price).toString(),
                            '${formatNumber.format(value.quantity * value.price)}',
                            0,
                            format: '%s %1s %2s %28s %n',
                          );
                        }
                        printer.printNewLine();
                        printer.printLeftRight('Total',
                            formatNumber.format(cart.totalAmount).toString(), 0,
                            format: '%-20s %20s %n');
                        printer.printLeftRight(
                            'Bayar',
                            formatNumber
                                .format(int.parse(_controller.text))
                                .toString(),
                            0,
                            format: '%-20s %20s %n');
                        printer.printLeftRight(
                            'Kembali',
                            '${formatNumber.format(int.parse(_controller.text) - cart.totalAmount)}',
                            0,
                            format: '%-20s %20s %n');
                        printer.printNewLine();
                        printer.printNewLine();
                        printer.printNewLine();
                      }
                      order.addOrder(
                        cart.items.values.toList(),
                        cart.totalAmount,
                      );
                      cart.clear();
                      _controller.text = '';
                    },
                    child: Text('Cetak Struk'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
