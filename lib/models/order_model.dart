import 'package:shop/models/cart_model.dart';

class OrderModel {
  final String orderId;
  final List<CartModel> products;
  final double amount;
  final DateTime dateTime;

  OrderModel({this.orderId, this.products, this.amount, this.dateTime});
}
