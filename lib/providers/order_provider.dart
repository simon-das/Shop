import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/cart_model.dart';
import 'package:shop/models/order_model.dart';

class OrderProvider extends ChangeNotifier {
  static const String orderBaseUrl =
      'https://shop-8484f-default-rtdb.firebaseio.com/orders';

  List<OrderModel> _orders = [];

  List<OrderModel> get orders => _orders;

  bool _isCheckOutLoading = false, _isLoading = true;

  bool get isLoading => _isLoading;

  set isLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  bool get isCheckOutLoading => _isCheckOutLoading;

  set isCheckOutLoading(bool loading) {
    _isCheckOutLoading = loading;
    notifyListeners();
  }

  Future<void> fetchOrders() async {
    _isLoading = true;
    http.get('$orderBaseUrl.json').then((response) {
      if (response.statusCode == 200) {
        _orders = [];
        var responseBody = json.decode(response.body) as Map<String, dynamic>;
        responseBody.forEach((orderId, order) {
          _orders.add(OrderModel(
              orderId: orderId,
              amount: order['amount'],
              dateTime: DateTime.parse(order['dateTime']),
              products: (order['products'] as List<dynamic>)
                  .map((cartItem) => CartModel(
                        cartId: cartItem['cartId'],
                        productTitle: cartItem['productTitle'],
                        productPrice: cartItem['productPrice'],
                        quantity: cartItem['quantity'],
                      ))
                  .toList()));
        });
      }
    }).catchError((error) {
      print(error);
    }).whenComplete(() => isLoading = false);
  }

  Future<http.Response> addOrder({OrderModel orderModel}) {
    isCheckOutLoading = true;
    return http
        .post('$orderBaseUrl.json',
            body: json.encode({
              'amount': orderModel.amount,
              'dateTime': orderModel.dateTime.toIso8601String(),
              'products': orderModel.products
                  .map((product) => {
                        'cartId': product.cartId,
                        'productTitle': product.productTitle,
                        'quantity': product.quantity,
                        'productPrice': product.productPrice
                      })
                  .toList()
            }))
        .whenComplete(() => isCheckOutLoading = false);
  }
}
