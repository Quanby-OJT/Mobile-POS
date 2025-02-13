import 'package:flutter/material.dart';
import '../admin/staff_folder/manager.dart';
import '../admin/staff_folder/cashier.dart';

class Staffs extends StatefulWidget {
  const Staffs({super.key});

  @override
  State<Staffs> createState() => _StaffsState();
}

class _StaffsState extends State<Staffs> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                width: 300,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TabBar(
                        controller: _tabController,
                        indicator: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(width: 2, color: Colors.black))),
                        labelColor: const Color.fromARGB(255, 0, 0, 0),
                        unselectedLabelColor:
                            const Color.fromARGB(179, 190, 190, 190),
                        tabs: const [
                          Tab(text: "Manager"),
                          Tab(text: "Cashier"),
                        ],
                      ),
                    )
                  ],
                )),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              buildManagerTable(),
              buildCashierTable(),
            ],
          ),
        ),
      ],
    );
  }
}
