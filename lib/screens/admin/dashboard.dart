import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text('Admin'),
    );
  }

  Widget _body() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Expanded(child: Text('data'))],
    );
  }
}
