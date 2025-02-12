import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  List<Map<String, dynamic>> inventory = [];
  final ImagePicker _picker = ImagePicker();

  void _addItem() {
    String name = '';
    String quantity = '';
    String price = '';
    Uint8List? imageBytes;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Item'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Item Name'),
                  onChanged: (value) => name = value,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => quantity = value,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Price (\$)'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => price = value,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final pickedFile =
                        await _picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      final bytes = await pickedFile.readAsBytes();
                      setState(() {
                        imageBytes = bytes;
                      });
                    }
                  },
                  child: Text('Choose Image'),
                ),
                imageBytes != null
                    ? Image.memory(imageBytes!, height: 100)
                    : Container(),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  inventory.add({
                    'name': name,
                    'quantity': int.tryParse(quantity) ?? 0,
                    'price': double.tryParse(price) ?? 0.0,
                    'image': imageBytes,
                  });
                });
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inventory')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: _addItem,
              child: Text('Add Item'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Image')),
                    DataColumn(label: Text('Item Name')),
                    DataColumn(label: Text('Quantity')),
                    DataColumn(label: Text('Price (\$)')),
                  ],
                  rows: inventory.map((item) {
                    return DataRow(cells: [
                      DataCell(item['image'] != null
                          ? Image.memory(item['image'], height: 50, width: 50)
                          : Icon(Icons.image_not_supported)),
                      DataCell(Text(item['name'])),
                      DataCell(Text(item['quantity'].toString())),
                      DataCell(Text(item['price'].toStringAsFixed(2))),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
