import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../widgets/main_drawer.dart';
import '../widgets/order_item.dart' as OrderItemWidget;
import '../providers/orders.dart';

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
      print(result.start.toString());
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

  @override
  Widget build(BuildContext context) {
    final formatNumber = NumberFormat.simpleCurrency(
      decimalDigits: 0,
      locale: 'id_ID',
    );
    final orderData = Provider.of<Orders>(context);
    if (filteredOrders == null) {
      filteredOrders = _filterOrder(orderData.orders);
      print(filteredOrders.length);
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
