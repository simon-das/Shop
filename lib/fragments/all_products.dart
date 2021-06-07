import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product_provider.dart';
import 'package:shop/widgets/product.dart';

class AllProducts extends StatefulWidget {
  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final ProductProvider productProvider =
        Provider.of<ProductProvider>(context);
    final products = productProvider.isFavorite
        ? productProvider.favoriteProducts
        : productProvider.allProducts;
    return productProvider.isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : GridView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                value: products[index],
                child: Product(),
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          );
  }
}
