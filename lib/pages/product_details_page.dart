import 'package:flutter/material.dart';
import 'package:shop/providers/product_model_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  static const String routeName = '/product_details_page';

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  ProductModelProvider product;

  @override
  Widget build(BuildContext context) {
    product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text('Product details'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              product.imageUrl,
              height: 300,
            ),
            Text(
              product.title,
              textAlign: TextAlign.center,
            ),
          ],
        ));
  }
}
