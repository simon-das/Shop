import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final Widget child;
  final int value;
  final Color color;

  Badge({@required this.child, @required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(right: 10, bottom: 0, child: child),
        if (value != 0)
          Positioned(
            right: 0,
            bottom: 42,
            child: CircleAvatar(
              radius: 17,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: FittedBox(
                  child: Text(
                    value.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
