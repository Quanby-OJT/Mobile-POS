import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mobile_pos/screens/admin/viewItems/view_order.dart';

class Order extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> products = [
      {
        'order': '123123',
        'type': '100',
        'product': 'coffee',
        'status': 'Available',
        'total': '100',
        'date': '2015-213-23'
      },
      {
        'order': '123sample1',
        'type': '100',
        'product': 'coffee',
        'status': 'Available',
        'total': '100',
        'date': '2015-213-23'
      },
      {
        'order': '123sample2',
        'type': '100',
        'product': 'coffee',
        'status': 'Available',
        'total': '100',
        'date': '2015-213-23'
      },
      {
        'order': '123sample3',
        'type': '100',
        'product': 'coffee',
        'status': 'Available',
        'total': '100',
        'date': '2015-213-23'
      },
      {
        'order': '123sample4',
        'type': '100',
        'product': 'coffee',
        'status': 'Available',
        'total': '100',
        'date': '2015-213-23'
      },
    ];

    Widget dataTablesOrders() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double columnWidth = constraints.maxWidth / 7;

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: 0,
                          headingRowHeight: 40,
                          horizontalMargin: 0,
                          columns: [
                            DataColumn(
                              label: SizedBox(
                                width: columnWidth,
                                child: Center(child: Text('Orders')),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: columnWidth,
                                child: Center(child: Text('Type')),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: columnWidth,
                                child: Center(child: Text('Status')),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: columnWidth,
                                child: Center(child: Text('Product')),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: columnWidth,
                                child: Center(child: Text('Total')),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: columnWidth,
                                child: Center(child: Text('Date')),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: columnWidth,
                                child: Center(child: Text('Action')),
                              ),
                            ),
                          ],
                          rows: products.map((product) {
                            return DataRow(
                              cells: [
                                DataCell(SizedBox(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          children: [
                                            Text(product['order']),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                                DataCell(SizedBox(
                                  width: columnWidth,
                                  child: Center(child: Text(product['type'])),
                                )),
                                DataCell(SizedBox(
                                  width: columnWidth,
                                  child: Center(child: Text(product['status'])),
                                )),
                                DataCell(SizedBox(
                                  width: columnWidth,
                                  child:
                                      Center(child: Text(product['product'])),
                                )),
                                DataCell(SizedBox(
                                  width: columnWidth,
                                  child: Center(child: Text(product['total'])),
                                )),
                                DataCell(SizedBox(
                                  width: columnWidth,
                                  child: Center(child: Text(product['date'])),
                                )),

                                // EDIT
                                DataCell(SizedBox(
                                  width: columnWidth,
                                  child: Center(
                                    child: IconButton(
                                      icon: Icon(Icons.more_horiz),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ViewOrder(
                                                    order: product['order'])));
                                      },
                                    ),
                                  ),
                                )),
                              ],
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          )
        ],
      );
    }

    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Orders',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: 300,
                    child: SizedBox(
                      child: TextField(
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          hintText: 'Search menu...',
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon:
                              const Icon(Icons.search, color: Colors.grey),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 16),
              dataTablesOrders()
            ],
          ),
        ),
      ),
    );
  }
}
