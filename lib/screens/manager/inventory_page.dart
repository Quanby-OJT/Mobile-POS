import 'dart:typed_data';
import 'dart:convert';
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
  List<dynamic> _products = []; // List to store products

  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProducts(); // Fetch products when the page loads
  }

  Future<void> _loadProducts() async {
    List<dynamic> products = await ApiService.fetchProducts();
    setState(() {
      _products.clear();
      _products.addAll(products);
    });

    print("Loaded products: $_products");
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

    // Get values from text fields
    String name = _nameController.text.trim();
    String quantity = _quantityController.text.trim();
    String price = _priceController.text.trim();

    if (name.isEmpty || quantity.isEmpty || price.isEmpty) {
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
    );

    if (response != null) {
      Map<String, dynamic> data = jsonDecode(response);
      setState(() {
        _imageUrl = data['imageUrl'];
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Image uploaded successfully!")),
      );

      _loadProducts(); // Refresh product list after adding a new product
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error uploading image!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Upload Image with Data')),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: "Quantity"),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _storeImage,
                child: Text('Store Image'),
              ),
              SizedBox(height: 20),
              _imageBytes != null
                  ? Image.memory(_imageBytes!, width: 200, height: 200)
                  : Text('No image selected'),
              SizedBox(height: 20),
              _imageUrl != null
                  ? Image.network(_imageUrl!, width: 200, height: 200)
                  : Text('No image stored yet'),
              SizedBox(height: 20),
              Divider(), // Divider to separate input fields and product list
              Text(
                'Product List',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: _products.isEmpty
                    ? Center(child: Text("No products found"))
                    : ListView.builder(
                        itemCount: _products.length,
                        itemBuilder: (context, index) {
                          var product = _products[index];
                          return ListTile(
                            leading: product['image_url'] != null
                                ? Image.network(product['image_url'],
                                    width: 50, height: 50)
                                : Icon(Icons.image_not_supported),
                            title: Text(product['name']),
                            subtitle: Text(
                                'Qty: ${product['quantity']} - Price: ${product['price']}'),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
