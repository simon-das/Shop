import 'package:flutter/material.dart';
import 'package:shop/models/order_model.dart';

class OrderProvider extends ChangeNotifier {
  List<OrderModel> _orders = [];

  List<OrderModel> get orders => _orders;

  void addOrder({OrderModel orderModel}) {
    _orders.add(orderModel);
  }
}
