import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/providers/product_model_provider.dart';

class ProductProvider extends ChangeNotifier {
  static const String productsUrl =
      'https://shop-8484f-default-rtdb.firebaseio.com/products.json';

  List<ProductModelProvider> _products = [
    ProductModelProvider(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    ProductModelProvider(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    ProductModelProvider(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    ProductModelProvider(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
    ProductModelProvider(
      id: 'p5',
      title: 'Another Pan',
      description: 'Meal you want.',
      price: 29.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  bool _isFavorite = false;

  bool get isFavorite => _isFavorite;

  set isFavorite(bool value) {
    _isFavorite = value;
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    var response = await http.get(productsUrl);
    var responseBody = json.decode(response.body) as Map<String, dynamic>;
    responseBody.forEach((productId, product) {
      _products.add(ProductModelProvider(
        id: productId,
        title: product['title'],
        description: product['description'],
        imageUrl: product['imageUrl'],
        price: product['price'],
        isFavorite: product['isFavorite'],
      ));
    });
  }

  List<ProductModelProvider> get allProducts {
    return _products;
  }

  List<ProductModelProvider> get favoriteProducts {
    return _products.where((product) => product.isFavorite).toList();
  }

  void removeProduct(String productId) {
    _products.removeWhere((product) => product.id == productId);
    notifyListeners();
  }

  void addProduct(ProductModelProvider productModelProvider) async {
    try {
      final response = await http.post(productsUrl,
          body: json.encode({
            'title': productModelProvider.title,
            'imageUrl': productModelProvider.imageUrl,
            'price': productModelProvider.price,
            'description': productModelProvider.description,
            'isFavorite': productModelProvider.isFavorite,
          }));

      print(response.body);

      _products.add(ProductModelProvider(
        id: json.decode(response.body)['name'],
        price: productModelProvider.price,
        title: productModelProvider.title,
        imageUrl: productModelProvider.imageUrl,
        description: productModelProvider.description,
      ));
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  void updateProduct(ProductModelProvider updatedProduct) {
    final int index =
        _products.indexWhere((product) => product.id == updatedProduct.id);
    _products[index] = updatedProduct;
    notifyListeners();
  }
}
