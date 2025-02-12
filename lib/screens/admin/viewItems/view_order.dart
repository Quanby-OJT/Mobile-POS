import 'package:flutter/material.dart';

class ViewOrder extends StatelessWidget {
  final String order;

  const ViewOrder({Key? key, required this.order}) : super(key: key);

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
