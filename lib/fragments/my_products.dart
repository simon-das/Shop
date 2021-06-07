import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/pages/add_or_edit_product_page.dart';
import 'package:shop/providers/product_model_provider.dart';
import 'package:shop/providers/product_provider.dart';

class MyProducts extends StatefulWidget {
  @override
  _MyProductsState createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).fetchProducts();
  }

  void editProduct(
      BuildContext context, ProductModelProvider productModelProvider) {
    Navigator.pushNamed(context, AddOrEditProductPage.routeName,
        arguments: productModelProvider);
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return productProvider.isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            shrinkWrap: true,
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
                                editProduct(context,
                                    productProvider.allProducts[index]);
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
            });
  }
}
