import 'package:flutter/material.dart';

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

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
