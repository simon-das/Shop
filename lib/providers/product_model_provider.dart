import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/providers/product_provider.dart';

class ProductModelProvider extends ChangeNotifier {
  final String id, title, imageUrl, description;
  final double price;
  bool isFavorite;

  ProductModelProvider(
      {this.id,
      this.title,
      this.imageUrl,
      this.price,
      this.description,
      this.isFavorite = false});

  void toggleFavoriteStatus(BuildContext context) {
    final bool oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    http
        .patch('${ProductProvider.productsBaseUrl}/$id.json',
            body: json.encode({
              'isFavorite': isFavorite,
            }))
        .then((response) {
      if (response.statusCode != 200) {
        isFavorite = oldStatus;
        notifyListeners();
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text('Something went wrong! Please try again!')));
      }
    }).catchError((error) {
      print(error);
    });
  }
}
