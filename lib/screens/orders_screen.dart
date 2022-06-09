import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../widgets/main_drawer.dart';
import '../widgets/order_item.dart' as OrderItemWidget;
import '../providers/orders.dart';
import '../providers/product.dart';
import '../providers/products.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = 'order-screen';
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  DateTimeRange? _selectedDateRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  var filteredOrders = null;

  final formatNumber = NumberFormat.simpleCurrency(
    decimalDigits: 0,
    locale: 'id_ID',
  );

  void _showDatePicker() async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime.now(),
      currentDate: DateTime.now(),
      initialDateRange: _selectedDateRange,
      saveText: 'Done',
    );
    if (result != null) {
      setState(() {
        _selectedDateRange = result;
      });
    }
  }

  List<OrderItem> _filterOrder(List<OrderItem> orders) {
    var resetTime = Duration(
      hours: -_selectedDateRange!.end.hour + 23,
      minutes: -_selectedDateRange!.end.minute + 59,
    );
    var resetTimeAfter = Duration(
      hours: -_selectedDateRange!.start.hour,
      minutes: -_selectedDateRange!.start.minute,
    );
    final filtered = orders
        .where((orderItem) =>
            orderItem.dateTime
                .isAfter(_selectedDateRange!.start.add(resetTimeAfter)) &&
            orderItem.dateTime.isBefore(_selectedDateRange!.end.add(resetTime)))
        .toList();
    return filtered;
  }

  double _totalAmount(List<OrderItem> filteredOrder) {
    var total = 0.0;
    filteredOrder.forEach((orderItem) {
      total += orderItem.amount;
    });
    return total;
  }

  List<Map<String, dynamic>> _getBestSeller(
      List<Product> products, List<OrderItem> orders) {
    List<Map<String, dynamic>> bestSeller = [];
    products.forEach((prod) {
      final Map<String, dynamic> temp = {
        'idProduct': '',
        'name': '',
        'sold': 0,
      };
      temp['idProduct'] = prod.id;
      temp['name'] = prod.name;
      temp['sold'] = 0;
      bestSeller.add(temp);
    });

    orders.forEach((order) {
      order.products.forEach((prods) {
        for (var i = 0; i < bestSeller.length; i++) {
          if (prods.id == bestSeller[i]['idProduct']) {
            bestSeller[i]['sold'] += prods.quantity;
          }
        }
      });
    });

    return bestSeller;
  }

  void exportPDF(BuildContext bContext, List<Product> products,
      List<OrderItem> orders) async {
    final pdf = pw.Document();

    var dataFont1 = await rootBundle.load("assets/fonts/Quicksand-Bold.ttf");
    var dataFont2 = await rootBundle.load("assets/fonts/Lato-Regular.ttf");
    var dataFont3 = await rootBundle.load("assets/fonts/Lato-Bold.ttf");
    var quickSand = pw.Font.ttf(dataFont1);
    var lato = pw.Font.ttf(dataFont2);
    var latoBold = pw.Font.ttf(dataFont3);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Container(
              alignment: pw.Alignment.center,
              color: PdfColors.deepPurple,
              width: double.infinity,
              child: pw.Text(
                'Laporan',
                style: pw.TextStyle(
                  fontSize: 50,
                  color: PdfColors.white,
                  fontWeight: pw.FontWeight.bold,
                  font: quickSand,
                ),
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              "Hasil Laporan dari Tanggal ${DateFormat('dd/MM/yyyy').format(_selectedDateRange!.start).split(' ')[0]} - ${DateFormat('dd/MM/yyyy').format(_selectedDateRange!.end).split(' ')[0]}",
              style: pw.TextStyle(
                fontSize: 18,
                fontWeight: pw.FontWeight.bold,
                font: quickSand,
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Column(
              children: orders
                  .map(
                    (e) => pw.Column(
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              '${e.id}',
                              style: pw.TextStyle(
                                fontSize: 18,
                                font: lato,
                              ),
                            ),
                            pw.Text(
                              '${DateFormat('dd/MM/yyyy-hh:mm').format(e.dateTime)}',
                              style: pw.TextStyle(
                                fontSize: 18,
                                font: lato,
                              ),
                            ),
                            pw.Text(
                              '${formatNumber.format(e.amount)}',
                              style: pw.TextStyle(
                                fontSize: 18,
                                fontWeight: pw.FontWeight.bold,
                                font: latoBold,
                              ),
                            ),
                          ],
                        ),
                        pw.Column(
                          children: e.products
                              .map((prod) => pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.spaceBetween,
                                      children: [
                                        pw.Text(
                                          prod.name,
                                          style: pw.TextStyle(
                                            fontSize: 18,
                                            font: lato,
                                          ),
                                        ),
                                        pw.Text(
                                          '${prod.quantity} x  ${formatNumber.format(prod.price)}',
                                          style: pw.TextStyle(
                                            fontSize: 16,
                                            font: lato,
                                          ),
                                        )
                                      ]))
                              .toList(),
                        ),
                        pw.Divider(thickness: 2),
                        pw.SizedBox(height: 10),
                      ],
                    ),
                  )
                  .toList(),
            ),
            pw.SizedBox(height: 5),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'Total Keseluruhan',
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                    font: latoBold,
                  ),
                ),
                pw.Text(
                  '${formatNumber.format(_totalAmount(filteredOrders))}',
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                    font: latoBold,
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              'Total masing-masing Menu yang dibeli : ',
              style: pw.TextStyle(
                fontSize: 20,
                fontWeight: pw.FontWeight.bold,
                font: quickSand,
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: List.generate(
                products.length,
                (index) => pw.Text(
                  "${_getBestSeller(products, orders)[index]['name']}  =  ${_getBestSeller(products, orders)[index]['sold']}",
                  style: pw.TextStyle(
                    fontSize: 18,
                    font: lato,
                  ),
                ),
              ),
            ),
          ];
        },
      ),
    ); // Page

    //simpan
    Uint8List bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/document-laporan.pdf');

    await file.writeAsBytes(bytes);

    await OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    final formatNumber = NumberFormat.simpleCurrency(
      decimalDigits: 0,
      locale: 'id_ID',
    );
    final orderData = Provider.of<Orders>(context);
    if (filteredOrders == null) {
      filteredOrders = _filterOrder(orderData.orders);
    }
    GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _globalKey,
      drawer: MainDrawer(),
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
                SizedBox(width: 10),
                Text(
                  'Laporan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                PopupMenuButton(
                  onSelected: (result) {
                    if (result == 0) {
                      exportPDF(
                        context,
                        Provider.of<Products>(context, listen: false).items,
                        filteredOrders,
                      );
                    }
                  },
                  icon: Icon(
                    Icons.more_vert,
                  ),
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.sim_card_download_rounded),
                          SizedBox(width: 5),
                          Text('Export ke PDF'),
                        ],
                      ),
                      value: 0,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                IconButton(
                  onPressed: _showDatePicker,
                  icon: Icon(
                    Icons.date_range,
                    size: 25,
                  ),
                ),
                Text(_selectedDateRange == null
                    ? '${DateFormat('dd/MM/yyyy').format(DateTime.now()).split(' ')[0]} - ${DateFormat('dd/MM/yyyy').format(DateTime.now()).split(' ')[0]}'
                    : '${DateFormat('dd/MM/yyyy').format(_selectedDateRange!.start).split(' ')[0]} - ${DateFormat('dd/MM/yyyy').format(_selectedDateRange!.end).split(' ')[0]}'),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      filteredOrders = _filterOrder(orderData.orders);
                    });
                  },
                  child: Text(
                    'Cari',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredOrders.length == 0
                ? Center(
                    child: Text(
                      'Belum ada laporan!',
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: filteredOrders.length,
                    itemBuilder: (ctx, i) => OrderItemWidget.OrderItem(
                      order: filteredOrders[i],
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Text(
                  'Total Penjualan',
                  style: TextStyle(fontSize: 16),
                ),
                Spacer(),
                Text(
                  formatNumber.format(_totalAmount(filteredOrders)),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
