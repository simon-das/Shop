import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/pages/add_or_edit_product_page.dart';
import 'package:shop/pages/authentication_page.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/my_products_page.dart';
import 'package:shop/pages/orders_page.dart';
import 'package:shop/pages/product_details_page.dart';
import 'package:shop/providers/auth_provider.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/providers/order_provider.dart';
import 'package:shop/providers/product_provider.dart';

void main() {
  runApp(Shop());
}

class Shop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthProvider()),
        ChangeNotifierProvider.value(value: CartProvider()),
        ChangeNotifierProvider.value(value: ProductProvider()),
        ChangeNotifierProvider.value(value: OrderProvider()),
      ],
      child: MaterialApp(
        title: 'Shop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
        ),
        routes: {
          '/': (context) => AuthenticationPage(),
          ProductDetailsPage.routeName: (context) => ProductDetailsPage(),
          CartPage.routeName: (context) => CartPage(),
          OrdersPage.routeName: (context) => OrdersPage(),
          MyProductsPage.routeName: (context) => MyProductsPage(),
          AddOrEditProductPage.routeName: (context) => AddOrEditProductPage(),
        },
      ),
    );
  }
}
