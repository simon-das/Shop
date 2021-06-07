import 'package:flutter/material.dart';
import 'package:shop/fragments/app_drawer.dart';
import 'package:shop/fragments/my_products.dart';
import 'package:shop/pages/add_or_edit_product_page.dart';

class MyProductsPage extends StatelessWidget {
  static const routeName = '/my_products_page';

  void addProduct(BuildContext context) {
    Navigator.pushNamed(context, AddOrEditProductPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Products'),
        actions: [
          IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                addProduct(context);
              })
        ],
      ),
      drawer: AppDrawer(),
      body: MyProducts(),
    );
  }
}
