import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/fragments/app_drawer.dart';
import 'package:shop/pages/add_or_edit_product_page.dart';
import 'package:shop/providers/product_model_provider.dart';
import 'package:shop/providers/product_provider.dart';

class MyProductsPage extends StatelessWidget {
  static const routeName = '/my_products_page';

  void addProduct(BuildContext context) {
    Navigator.pushNamed(context, AddOrEditProductPage.routeName);
  }

  void editProduct(
      BuildContext context, ProductModelProvider productModelProvider) {
    Navigator.pushNamed(context, AddOrEditProductPage.routeName,
        arguments: productModelProvider);
  }

  @override
  Widget build(BuildContext context) {
    final ProductProvider productProvider =
        Provider.of<ProductProvider>(context);
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
      body: ListView.builder(
          itemCount: productProvider.allProducts.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        productProvider.allProducts[index].imageUrl),
                  ),
                  title: Text(productProvider.allProducts[index].title),
                  trailing: Container(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.edit),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              editProduct(
                                  context, productProvider.allProducts[index]);
                            }),
                        IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () {
                              productProvider.removeProduct(
                                  productProvider.allProducts[index].id);
                            })
                      ],
                    ),
                  ),
                ),
                Divider()
              ],
            );
          }),
    );
  }
}
