import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/providers/product_model_provider.dart';

class ProductProvider extends ChangeNotifier {
  static const String productsBaseUrl =
      'https://shop-8484f-default-rtdb.firebaseio.com/products';

  List<ProductModelProvider> _products = [];

  bool _isFavorite = false, _isLoading = true;

  get isLoading => _isLoading;

  set isLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  bool get isFavorite => _isFavorite;

  set isFavorite(bool value) {
    _isFavorite = value;
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    _products = [];
    var response = await http.get(productsBaseUrl + '.json');
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

    _isLoading = false;

    notifyListeners();
  }

  List<ProductModelProvider> get allProducts {
    return _products;
  }

  List<ProductModelProvider> get favoriteProducts {
    return _products.where((product) => product.isFavorite).toList();
  }

  Future<void> removeProduct(String productId) {
    isLoading = true;
    return http.delete(productsBaseUrl + '/$productId.json').then((response) {
      if (response.statusCode == 200) {
        _products.removeWhere((product) => product.id == productId);
        notifyListeners();
      }
    }).catchError((error) {
      print(error);
    }).whenComplete(() => _isLoading = false);
  }

  void addProduct(ProductModelProvider productModelProvider) async {
    isLoading = true;
    try {
      final response = await http.post(productsBaseUrl + '.json',
          body: json.encode({
            'title': productModelProvider.title,
            'imageUrl': productModelProvider.imageUrl,
            'price': productModelProvider.price,
            'description': productModelProvider.description,
            'isFavorite': productModelProvider.isFavorite,
          }));

      _products.add(ProductModelProvider(
        id: json.decode(response.body)['name'],
        price: productModelProvider.price,
        title: productModelProvider.title,
        imageUrl: productModelProvider.imageUrl,
        description: productModelProvider.description,
      ));
    } catch (error) {
      print(error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateProduct(ProductModelProvider updatedProduct) {
    isLoading = true;
    http
        .patch(productsBaseUrl + '/${updatedProduct.id}.json',
            body: json.encode({
              'title': updatedProduct.title,
              'imageUrl': updatedProduct.imageUrl,
              'price': updatedProduct.price,
              'isFavorite': updatedProduct.isFavorite,
              'description': updatedProduct.description,
            }))
        .then((response) {
      if (response.statusCode == 200) {
        final int index =
            _products.indexWhere((product) => product.id == updatedProduct.id);
        _products[index] = updatedProduct;
        notifyListeners();
      }
    }).whenComplete(() => _isLoading = false);
  }
}
