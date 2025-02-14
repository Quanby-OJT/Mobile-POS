import 'package:flutter/material.dart';
import '../admin/Staffs.dart';
import '../admin/dashboard.dart';
import '../admin/logs.dart';
import '../admin/reports.dart';
import '../admin/status.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({super.key});

  @override
  _AdminMainPageState createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    AdminDashboard(),
    Logs(),
    Staffs(),
    Reports(),
    Status(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 20, title: Text('Admin Dashboard')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Center(
                child: Text(
                  'Dashboard',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () => _onItemTapped(0),
            ),
            ListTile(
              leading: Icon(Icons.inventory),
              title: Text('Staff'),
              onTap: () => _onItemTapped(2),
            ),
            ListTile(
              leading: Icon(Icons.menu),
              title: Text('Status'),
              onTap: () => _onItemTapped(4),
            ),
            ListTile(
              leading: Icon(Icons.menu),
              title: Text('Logs'),
              onTap: () => _onItemTapped(1),
            ),
            ListTile(
              leading: Icon(Icons.inventory),
              title: Text('Reports'),
              onTap: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
