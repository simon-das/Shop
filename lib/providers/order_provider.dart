import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/order_model.dart';

class OrderProvider extends ChangeNotifier {
  static const String orderBaseUrl =
      'https://shop-8484f-default-rtdb.firebaseio.com/orders';

  List<OrderModel> _orders = [];

  List<OrderModel> get orders => _orders;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<http.Response> addOrder({OrderModel orderModel}) {
    isLoading = true;
    return http
        .post('$orderBaseUrl.json',
            body: json.encode({
              'amount': orderModel.amount.toString(),
              'dateTime': orderModel.dateTime.toString(),
              'products': orderModel.products
                  .map((product) => {
                        'cartId': product.cartId,
                        'productTitle': product.productTitle,
                        'quantity': product.quantity.toString(),
                        'productPrice': product.productPrice.toString()
                      })
                  .toList()
            }))
        .whenComplete(() => isLoading = false);
  }
}
