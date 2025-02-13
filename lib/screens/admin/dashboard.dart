import 'package:flutter/material.dart';
import 'package:mobile_pos/screens/admin/graph/order.dart';
import 'package:mobile_pos/screens/admin/graph/product.dart';
import 'package:mobile_pos/screens/admin/graph/sale.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Expanded(
                  child: Card(
                    color: Colors.black87,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Weekly Sale',
                                style: TextStyle(color: Colors.white70),
                              ),
                              Icon(Icons.trending_up, color: Colors.white70),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            '2,318',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Card(
                    color: Colors.black87,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Weekly Sale',
                                style: TextStyle(color: Colors.white70),
                              ),
                              Icon(Icons.trending_up, color: Colors.white70),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            '2,318',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Card(
                    color: Colors.black87,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Monthly Sale',
                                style: TextStyle(color: Colors.white70),
                              ),
                              Icon(Icons.trending_up, color: Colors.white70),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            '2,318',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20, right: 10),
                            decoration: BoxDecoration(),
                            child: Column(
                              children: [
                                Sale(),
                                SizedBox(height: 16),
                                ProductStatus(),
                                SizedBox(height: 16),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Order()
          ],
        ),
      ),
    );
  }
}
