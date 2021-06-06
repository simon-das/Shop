import 'package:flutter/cupertino.dart';
import 'package:shop/models/cart_model.dart';

class CartProvider extends ChangeNotifier {
  int itemCount = 0;
  Map<String, CartModel> _cartItems = {};
  bool isItemExist;

  Map<String, CartModel> get cartItems => _cartItems;

  void addItem({String productId, String productTitle, double productPrice}) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (existingItem) => CartModel(
                productTitle: existingItem.productTitle,
                productPrice: existingItem.productPrice,
                cartId: existingItem.cartId,
                quantity: existingItem.quantity + 1,
              ));
    } else {
      _cartItems.putIfAbsent(
          productId,
          () => CartModel(
                productPrice: productPrice,
                productTitle: productTitle,
                quantity: 1,
                cartId: DateTime.now().toString(),
              ));
    }

    notifyListeners();
  }

  double get totalAmount {
    double totalAmount = 0;
    _cartItems.forEach((key, value) {
      totalAmount += value.productPrice * value.quantity;
    });

    return totalAmount;
  }

  void removeItem(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (_cartItems[productId].quantity > 1) {
      cartItems.update(
          productId,
          (existingItem) => CartModel(
                cartId: existingItem.cartId,
                productTitle: existingItem.productTitle,
                productPrice: existingItem.productPrice,
                quantity: existingItem.quantity - 1,
              ));

      notifyListeners();
    } else {
      removeItem(productId);
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
