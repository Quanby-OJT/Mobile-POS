import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../viewItems/view_product.dart';

class ProductStatus extends StatelessWidget {
  ProductStatus({super.key});

  final List<Map<String, dynamic>> products = [
    {'name': 'Coffee Meal', 'count': 12},
    {'name': 'Burger', 'count': 12},
    {'name': 'Rice Meal', 'count': 8},
    {'name': 'Soda', 'count': 20},
    {'name': 'Coffee Meal', 'count': 12},
    {'name': 'Burger', 'count': 12},
    {'name': 'Rice Meal', 'count': 8},
    {'name': 'Soda', 'count': 20},
    {'name': 'Coffee Meal', 'count': 12},
    {'name': 'Burger', 'count': 12},
    {'name': 'Rice Meal', 'count': 8},
    {'name': 'Soda', 'count': 20},
    {'name': 'Coffee Meal', 'count': 12},
    {'name': 'Burger', 'count': 12},
    {'name': 'Rice Meal', 'count': 8},
    {'name': 'Soda', 'count': 2},
    {'name': 'Coffee Meal', 'count': 12},
    {'name': 'Burger', 'count': 9},
    {'name': 'Rice Meal', 'count': 8},
    {'name': 'Soda', 'count': 20},
    {'name': 'Coffee Meal', 'count': 12},
    {'name': 'Burger', 'count': 12},
    {'name': 'Rice Meal', 'count': 8},
    {'name': 'Soda', 'count': 20},
    {'name': 'Coffee Meal', 'count': 12},
    {'name': 'Burger', 'count': 12},
    {'name': 'Rice Meal', 'count': 8},
    {'name': 'Soda', 'count': 20},
    {'name': 'Coffee Meal', 'count': 9},
    {'name': 'Burger', 'count': 12},
    {'name': 'Rice Meal', 'count': 8},
    {'name': 'Soda', 'count': 20},
    {'name': 'Coffee Meal', 'count': 12},
    {'name': 'Burger', 'count': 12},
    {'name': 'Rice Meal', 'count': 8},
    {'name': 'Soda', 'count': 24},
  ];

  @override
  Widget build(BuildContext context) {
    int maxCount =
        products.map((p) => p['count']).reduce((a, b) => a > b ? a : b);
    int lowCount = 10;
    int zeroCount = 0;

    return Center(
      child: Card(
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Product Status',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              SizedBox(
                height: 500,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        5,
                        (index) {
                          int value = ((maxCount + 5) / 5 * index).toInt();
                          return SizedBox(
                            height: 80,
                            child: Text(
                              '$value',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          );
                        },
                      ).reversed.toList(),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          width: products.length * 50.0,
                          child: BarChart(
                            BarChartData(
                              maxY: maxCount + 15,
                              alignment: BarChartAlignment.spaceAround,
                              barGroups: products.asMap().entries.map((entry) {
                                int index = entry.key;
                                var product = entry.value;
                                return BarChartGroupData(
                                  x: index,
                                  barsSpace: 20,
                                  barRods: [
                                    BarChartRodData(
                                      toY: product['count'].toDouble(),
                                      color: product['count'] == maxCount
                                          ? const Color.fromARGB(
                                              255, 36, 255, 2)
                                          : (product['count'] > lowCount &&
                                                  product['count'] < maxCount)
                                              ? Colors.blue
                                              : (product['count'] > zeroCount &&
                                                      product['count'] <
                                                          lowCount)
                                                  ? Colors.green
                                                  : Colors.red,
                                      width: 30,
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
                                    getTitlesWidget:
                                        (double value, TitleMeta meta) {
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
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                              ),
                              borderData: FlBorderData(show: false),
                              barTouchData: BarTouchData(
                                touchTooltipData: BarTouchTooltipData(
                                  tooltipPadding: EdgeInsets.all(7),
                                  getTooltipItem:
                                      (group, groupIndex, rod, rodIndex) {
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
                                    int index =
                                        response.spot!.touchedBarGroupIndex;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ViewProduct(
                                            product: products[index]['name']),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
