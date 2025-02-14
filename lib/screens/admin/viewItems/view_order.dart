import 'package:flutter/material.dart';

class ViewOrder extends StatelessWidget {
  final String order;

  const ViewOrder({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$order Products'),
      ),
      body: Center(
        child: Text('Order for $order'),
      ),
    );
  }
}
