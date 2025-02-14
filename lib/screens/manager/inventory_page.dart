import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mobile_pos/services/api_service.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  Uint8List? _imageBytes;
  String? _imageName;
  String? _imageUrl;
  List<dynamic> _products = [];
  bool _showForm = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final SingleValueDropDownController _categoryController =
      SingleValueDropDownController();

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    List<dynamic> products = await ApiService.fetchProducts();
    setState(() {
      _products.clear();
      _products.addAll(products);
    });
  }

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _imageBytes = result.files.first.bytes;
        _imageName = result.files.first.name;
      });
    }
  }

  Future<void> _storeImage() async {
    if (_imageBytes == null || _imageName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select an image first!")),
      );
      return;
    }

    String name = _nameController.text.trim();
    String quantity = _quantityController.text.trim();
    String price = _priceController.text.trim();
    String? category = _categoryController.dropDownValue?.name.trim();

    if (name.isEmpty ||
        quantity.isEmpty ||
        price.isEmpty ||
        (category?.isEmpty ?? true)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields!")),
      );
      return;
    }

    String? response = await ApiService.uploadImage(
      _imageBytes!,
      _imageName!,
      name,
      quantity,
      price,
      category ?? "",
    );

    if (response != null) {
      Map<String, dynamic> data = jsonDecode(response);
      setState(() {
        _imageUrl = data['imageUrl'];
        _showForm = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Image uploaded successfully!")),
      );

      _loadProducts();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error uploading image!")),
      );
    }
  }

  void _showPopupForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Product"),
          content: Container(
            width: 400, // Adjust width to fit the content
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // First Column - Form Fields
                Expanded(
                  flex: 2, // Allocating more space for form inputs
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        cursorColor: Colors.black,
                        controller: _nameController,
                        decoration: _inputDecoration("Product Name"),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        cursorColor: Colors.black,
                        controller: _quantityController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration("Quantity"),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        cursorColor: Colors.black,
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration("Price"),
                      ),
                      SizedBox(height: 10),
                      DropDownTextField(
                        textFieldDecoration: _inputDecoration("Select an item"),
                        controller: _categoryController,
                        dropDownList: [
                          DropDownValueModel(
                              name: 'Appetizers and Salads', value: 'value'),
                          DropDownValueModel(
                              name: 'Breads and Bakery', value: 'value'),
                          DropDownValueModel(name: 'Kids Menu', value: 'value'),
                          DropDownValueModel(
                              name: 'All Day Liberty Gourmet Breakfast',
                              value: 'value'),
                          DropDownValueModel(
                              name: 'Wraps and Sandwiches', value: 'value'),
                          DropDownValueModel(
                              name: 'Main Course', value: 'value'),
                          DropDownValueModel(name: 'Drinks', value: 'value'),
                          DropDownValueModel(name: 'Desserts', value: 'value')
                        ],
                        onChanged: (value) {
                          print("Selected: ${value.name}");
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 20), // Space between columns

                // Second Column - Image Picker
                Expanded(
                  flex: 2, // Less space for image section
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _imageBytes != null
                          ? Image.memory(_imageBytes!,
                              height: 150, width: 150, fit: BoxFit.cover)
                          : Container(
                              height: 150,
                              width: 150,
                              color: Colors.grey[300],
                              child: Icon(Icons.image,
                                  size: 50, color: Colors.grey),
                            ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _pickImage,
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(100, 50),
                            backgroundColor: Color(0xFFC19435),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: Text(
                          "Pick Image",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _storeImage();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(100, 50),
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              child: Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

// Reusable input decoration
  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.black),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFF4F1F8),
        appBar: AppBar(
            backgroundColor: Color(0xFFF4F1F8),
            title: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text('Inventory Management'))),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: 200,
                  child: TextField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: 'Search product...',
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
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 16, bottom: 16, left: 30, right: 30),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Product List',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                          onPressed: () => _showPopupForm(context),
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(100, 50),
                              backgroundColor: Color(0xFFC19435),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          child: Text(
                            "Add Product",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: DataTableTheme(
                            data: DataTableThemeData(
                              dataRowMinHeight: 50, // Minimum height of the row
                              dataRowMaxHeight: 70,
                            ),
                            child: DataTable(
                              columns: [
                                DataColumn(label: Text('Image')),
                                DataColumn(label: Text('Product Name')),
                                DataColumn(label: Text('Product ID')),
                                DataColumn(label: Text('Price')),
                                DataColumn(label: Text('Stock')),
                                DataColumn(label: Text('Category')),
                                DataColumn(label: Text('Status')),
                                DataColumn(label: Text('Action'))
                              ],
                              rows: _products.map((product) {
                                return DataRow(cells: [
                                  DataCell(
                                    product['image_url'] != null &&
                                            product['image_url'].isNotEmpty
                                        ? Image.network(product['image_url'],
                                            width: 50, height: 50)
                                        : Icon(Icons.image_not_supported),
                                  ),
                                  DataCell(Text(product['name'] ?? 'N/A')),
                                  DataCell(
                                      Text(product['id']?.toString() ?? 'N/A')),
                                  DataCell(Text(product['price'] != null
                                      ? '\$${product['price']}'
                                      : 'N/A')),
                                  DataCell(Text(
                                      product['quantity']?.toString() ??
                                          'N/A')),
                                  DataCell(Text(product['category'] ?? 'N/A')),
                                  DataCell(
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(
                                            product['status'] ?? ''),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        product['status'] ?? 'N/A',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  DataCell(Text(product['category'] ?? 'N/A')),
                                ]);
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'active':
        return Colors.green;
      case 'inactive':
        return Colors.red;
      case 'on sale':
        return Colors.blue;
      case 'bouncing':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
