import 'package:flutter/material.dart';
import 'package:shop/models/order_model.dart';

class OrderItem extends StatefulWidget {
  final OrderModel order;

  OrderItem({this.order});

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount.toStringAsFixed(2)}'),
            subtitle: Text(widget.order.dateTime.toString()),
            trailing: IconButton(
              icon: Icon(_expanded
                  ? Icons.arrow_drop_up_sharp
                  : Icons.arrow_drop_down_sharp),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              constraints: BoxConstraints(
                maxHeight: 200,
              ),
              height: (widget.order.products.length * 50).toDouble(),
              child: ListView.builder(
                itemCount: widget.order.products.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(widget.order.products[index].productTitle),
                  trailing: Text('${widget.order.products[index].quantity}x'),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
