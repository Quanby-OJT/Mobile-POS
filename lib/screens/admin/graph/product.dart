import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mobile_pos/screens/admin/viewItems/view_product.dart';

class ProductStatus extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {'name': 'Coffee Meal', 'count': 12},
    {'name': 'Burger', 'count': 12},
    {'name': 'Rice Meal', 'count': 8},
    {'name': 'Soda', 'count': 20},
    {'name': 'Fries & Drinks', 'count': 34},
    {'name': 'Coke', 'count': 20},
  ];

  @override
  Widget build(BuildContext context) {
    int maxCount =
        products.map((p) => p['count']).reduce((a, b) => a > b ? a : b);

    return Center(
      child: Card(
        margin: EdgeInsets.only(top: 20),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Product Status',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.more_horiz),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 16),
              AspectRatio(
                aspectRatio: 1.5,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    barGroups: products.asMap().entries.map((entry) {
                      int index = entry.key;
                      var product = entry.value;
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: product['count'].toDouble(),
                            color: product['count'] == maxCount
                                ? Colors.red
                                : Colors.blue,
                            width: 25,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                        showingTooltipIndicators: [0],
                      );
                    }).toList(),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                products[value.toInt()]['name'],
                                style: TextStyle(fontSize: 10),
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles:
                            SideTitles(showTitles: true, reservedSize: 40),
                      ),
                      topTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: false),
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return BarTooltipItem(
                            '${rod.toY.toInt()}',
                            TextStyle(color: Colors.white),
                          );
                        },
                      ),
                      touchCallback: (event, response) {
                        if (event is FlTapUpEvent &&
                            response != null &&
                            response.spot != null) {
                          int index = response.spot!.touchedBarGroupIndex;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ViewProduct(product: products[index]['name']),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
