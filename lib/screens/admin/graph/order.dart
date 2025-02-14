import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mobile_pos/screens/admin/viewItems/view_order.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String numberSet = '20';
  int currentPage = 1;
  final int totalPages = 5;

  void _nextPage(int page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> products = [
      {
        'order': '123123',
        'type': 'Dine in',
        'product': 'coffee',
        'status': 'Available',
        'total': '100',
        'date': '2015-213-23'
      },
      {
        'order': '123sample1',
        'type': 'Dine in',
        'product': 'coffee',
        'status': 'Available',
        'total': '100',
        'date': '2015-213-23'
      },
      {
        'order': '123sample2',
        'type': 'Take out',
        'product': 'coffee',
        'status': 'Available',
        'total': '100',
        'date': '2015-213-23'
      },
      {
        'order': '123sample3',
        'type': 'Take out',
        'product': 'coffee',
        'status': 'Available',
        'total': '100',
        'date': '2015-213-23'
      },
      {
        'order': '123sample4',
        'type': 'Take out',
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
                          columns: [
                            DataColumn(
                              label: SizedBox(
                                width: columnWidth,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(),
                                                child: Expanded(
                                                    child: Row(
                                                  children: [
                                                    Text(
                                                      'Order ID',
                                                    ),
                                                    IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(
                                                          Icons.unfold_more,
                                                          size: 15,
                                                        ))
                                                  ],
                                                )),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                                  ],
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: columnWidth,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(),
                                                child: Expanded(
                                                    child: Row(
                                                  children: [
                                                    Text(
                                                      'Type',
                                                    ),
                                                    IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(
                                                          Icons.unfold_more,
                                                          size: 15,
                                                        ))
                                                  ],
                                                )),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                                  ],
                                ),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: columnWidth,
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(),
                                            child: Expanded(
                                                child: Row(
                                              children: [
                                                Text(
                                                  'Status',
                                                ),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      Icons.unfold_more,
                                                      size: 15,
                                                    ))
                                              ],
                                            )),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: columnWidth,
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(),
                                            child: Expanded(
                                                child: Row(
                                              children: [
                                                Text(
                                                  'Product',
                                                ),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      Icons.unfold_more,
                                                      size: 15,
                                                    ))
                                              ],
                                            )),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: columnWidth,
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(),
                                            child: Expanded(
                                                child: Row(
                                              children: [
                                                Text(
                                                  'Total',
                                                ),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      Icons.unfold_more,
                                                      size: 15,
                                                    ))
                                              ],
                                            )),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: columnWidth,
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(),
                                            child: Expanded(
                                                child: Row(
                                              children: [
                                                Text(
                                                  'Date',
                                                ),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      Icons.unfold_more,
                                                      size: 15,
                                                    ))
                                              ],
                                            )),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                              ),
                            ),
                            DataColumn(
                              label: SizedBox(
                                width: columnWidth,
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Action'),
                                  ],
                                )),
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
                                  child: Center(
                                    child: Text(product['type']),
                                  ),
                                )),
                                DataCell(SizedBox(
                                  width: columnWidth,
                                  child: Center(child: Text(product['status'])),
                                )),
                                DataCell(SizedBox(
                                  width: columnWidth,
                                  child: Container(
                                      child: Center(
                                    child: Text(product['product']),
                                  )),
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
                                      icon: Icon(Icons.visibility),
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
              dataTablesOrders(),
              Divider(),
              SizedBox(
                height: 20,
              ),
              resultControl()
            ],
          ),
        ),
      ),
    );
  }

  Widget resultControl() {
    return Container(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Showing'),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: PopupMenuButton<String>(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onSelected: (String value) {
                      setState(() {
                        numberSet = value;
                      });
                    },
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(value: '20', child: Text('20')),
                      PopupMenuItem(value: '30', child: Text('30')),
                      PopupMenuItem(value: '50', child: Text('50')),
                    ],
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 222, 222, 222),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(numberSet),
                          Icon(Icons.arrow_drop_down, color: Colors.black),
                        ],
                      ),
                    ),
                  ),
                ),
                Text('of 123'),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios, size: 16),
                onPressed:
                    currentPage > 1 ? () => _nextPage(currentPage - 1) : null,
              ),
              for (int i = 1; i <= totalPages; i++)
                GestureDetector(
                  onTap: () => _nextPage(i),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: currentPage == i
                          ? Colors.blue[100]
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      i.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: currentPage == i ? Colors.blue : Colors.black,
                      ),
                    ),
                  ),
                ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios, size: 16),
                onPressed: currentPage < totalPages
                    ? () => _nextPage(currentPage + 1)
                    : null,
              ),
            ],
          )
        ],
      ),
    ));
  }
}
