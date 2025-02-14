import 'package:flutter/material.dart';

class ViewProduct extends StatelessWidget {
  final String product;

  const ViewProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$product Products'),
      ),
      body: Center(
        child: Text('Products for $product'),
      ),
    );
  }
}
