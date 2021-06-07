import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/fragments/all_products.dart';
import 'package:shop/fragments/app_drawer.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/providers/product_provider.dart';
import 'package:shop/widgets/badge.dart';

enum FilterOptions { favorite, all }

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductProvider productProvider =
        Provider.of<ProductProvider>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (selectedOption) {
              if (selectedOption == FilterOptions.favorite) {
                productProvider.isFavorite = true;
              } else {
                productProvider.isFavorite = false;
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                    child: Text('Favorites'), value: FilterOptions.favorite),
                PopupMenuItem(child: Text('All'), value: FilterOptions.all),
              ];
            },
            icon: Icon(Icons.more_vert),
          )
        ],
        title: Center(
          child: Consumer<ProductProvider>(
            builder: (ctx, products, _) => Text(
              products.isFavorite ? 'Favorite Products' : 'All Products',
            ),
          ),
        ),
      ),
      body: AllProducts(),
      floatingActionButton: Consumer<CartProvider>(
        builder: (BuildContext context, value, Widget child) {
          return Badge(
            child: child,
            value: value.cartItems.length,
          );
        },
        child: FloatingActionButton(
          child: Icon(Icons.shopping_cart),
          onPressed: () {
            Navigator.pushNamed(context, CartPage.routeName);
          },
        ),
      ),
    );
  }
}
