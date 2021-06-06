class CartModel {
  final String cartId;
  final String productTitle;
  final double productPrice;
  int quantity;

  CartModel({this.productTitle, this.productPrice, this.cartId, this.quantity});
}
