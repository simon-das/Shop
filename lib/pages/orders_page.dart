import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/fragments/app_drawer.dart';
import 'package:shop/providers/order_provider.dart';
import 'package:shop/widgets/order_item.dart';

class OrdersPage extends StatelessWidget {
  static const String routeName = '/orders_page';
  @override
  Widget build(BuildContext context) {
    final OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orderProvider.orders.length,
        itemBuilder: (context, index) =>
            OrderItem(order: orderProvider.orders[index]),
      ),
    );
  }
}
