import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/fragments/app_drawer.dart';
import 'package:shop/providers/order_provider.dart';
import 'package:shop/widgets/order_item.dart';

class OrdersPage extends StatefulWidget {
  static const String routeName = '/orders_page';

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<OrderProvider>(context, listen: false).fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    final OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      drawer: AppDrawer(),
      body: orderProvider.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : orderProvider.orders.length < 1
              ? Center(child: Text('No orders!'))
              : ListView.builder(
                  itemCount: orderProvider.orders.length,
                  itemBuilder: (context, index) =>
                      OrderItem(order: orderProvider.orders[index]),
                ),
    );
  }
}
