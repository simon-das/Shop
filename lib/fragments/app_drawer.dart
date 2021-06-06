import 'package:flutter/material.dart';
import 'package:shop/pages/my_products_page.dart';
import 'package:shop/pages/orders_page.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello friends!'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Products'),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.pushNamed(context, OrdersPage.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop_two_outlined),
            title: Text('My Products'),
            onTap: () {
              Navigator.pushNamed(context, MyProductsPage.routeName);
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
