import 'package:flutter/material.dart';

class ViewProduct extends StatelessWidget {
  final String product;

  const ViewProduct({Key? key, required this.product}) : super(key: key);

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
