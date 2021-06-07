import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/order_model.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/providers/order_provider.dart';

class CartPage extends StatelessWidget {
  static const String routeName = '/cart_page';

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Products Cart'),
      ),
      body: Column(
        children: [
          //total
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 8, top: 8, bottom: 8),
              child: Row(
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 22),
                  ),
                  Spacer(),
                  Chip(
                      label: Text(
                        '\$${cartProvider.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      backgroundColor: Theme.of(context).primaryColor),
                  Consumer<OrderProvider>(
                    builder: (context, orderProvider, child) {
                      return FlatButton(
                        onPressed: cartProvider.cartItems.length == 0
                            ? null
                            : () {
                                //add order
                                Provider.of<OrderProvider>(context,
                                        listen: false)
                                    .addOrder(
                                        orderModel: OrderModel(
                                  orderId: DateTime.now().toString(),
                                  products:
                                      cartProvider.cartItems.values.toList(),
                                  amount: cartProvider.totalAmount,
                                  dateTime: DateTime.now(),
                                ))
                                    .then((response) {
                                  if (response.statusCode == 200) {
                                    //clear cart
                                    cartProvider.clearCart();
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text('Order added!'),
                                    ));
                                  } else {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                          'Something went wrong! Please try again!'),
                                    ));
                                  }
                                }).catchError((error) {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Something went wrong! Please try again!'),
                                  ));
                                  print(error);
                                });
                              },
                        child: orderProvider.isLoading
                            ? CircularProgressIndicator()
                            : Text(
                                'Check Out',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          //cart items list
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 6.0, right: 16),
                  child: Column(
                    children: [
                      Divider(),
                      Dismissible(
                        confirmDismiss: (direction) {
                          return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Are you sure'),
                                content: Text(
                                    'Do you want to delete the item from cart?'),
                                actions: [
                                  TextButton(
                                    child: Text('No'),
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                      },
                                      child: Text('Yes'))
                                ],
                              );
                            },
                          );
                        },
                        key: ValueKey(cartProvider.cartItems.values
                            .toList()[index]
                            .cartId),
                        background: Container(
                          color: Theme.of(context).errorColor,
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.delete,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          Provider.of<CartProvider>(context, listen: false)
                              .removeItem(
                                  cartProvider.cartItems.keys.toList()[index]);
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 35,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: FittedBox(
                                child: Text(
                                  '\$${cartProvider.cartItems.values.toList()[index].productPrice.toStringAsFixed(2)}',
                                  textAlign: TextAlign.center,
                                  softWrap: false,
                                ),
                              ),
                            ),
                          ),
                          title: Text(cartProvider.cartItems.values
                              .toList()[index]
                              .productTitle),
                          subtitle: Text('Total: \$' +
                              (cartProvider.cartItems.values
                                          .toList()[index]
                                          .productPrice *
                                      cartProvider.cartItems.values
                                          .toList()[index]
                                          .quantity)
                                  .toStringAsFixed(2)),
                          trailing: Text(
                              '${cartProvider.cartItems.values.toList()[index].quantity}x'),
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                );
              },
              itemCount: cartProvider.cartItems.length,
            ),
          )
        ],
      ),
    );
  }
}
