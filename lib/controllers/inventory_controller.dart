// import 'dart:typed_data';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:mobile_pos/services/api_service.dart';

// class InventoryController {
//   ValueNotifier<List<dynamic>> products = ValueNotifier([]);

//   Uint8List? imageBytes;
//   String? imageName;

//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController quantityController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();

//   void loadProducts() async {
//     List<dynamic> fetchedProducts = await ApiService.fetchProducts();
//     products.value = fetchedProducts;
//   }

//   Future<void> pickImage() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//     );

//     if (result != null) {
//       imageBytes = result.files.first.bytes;
//       imageName = result.files.first.name;
//     }
//   }

//   Future<void> storeImage(BuildContext context) async {
//     if (imageBytes == null || imageName == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please select an image first!")),
//       );
//       return;
//     }

//     String name = nameController.text.trim();
//     String quantity = quantityController.text.trim();
//     String price = priceController.text.trim();

//     if (name.isEmpty || quantity.isEmpty || price.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please fill all fields!")),
//       );
//       return;
//     }

//     String? response = await ApiService.uploadImage(
//       imageBytes!,
//       imageName!,
//       name,
//       quantity,
//       price,
//     );

//     if (response != null) {
//       loadProducts();
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Product added successfully!")),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Error adding product!")),
//       );
//     }
//   }

//   void showPopupForm(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Add Product"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: nameController,
//                 decoration: const InputDecoration(labelText: "Product Name"),
//               ),
//               const SizedBox(height: 10),
//               TextField(
//                 controller: quantityController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(labelText: "Quantity"),
//               ),
//               const SizedBox(height: 10),
//               TextField(
//                 controller: priceController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(labelText: "Price"),
//               ),
//               const SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: pickImage,
//                 child: const Text("Pick Image"),
//               ),
//             ],
//           ),
//           actions: [
//             ElevatedButton(
//               onPressed: () {
//                 storeImage(context);
//                 Navigator.of(context).pop();
//               },
//               child: const Text("Submit"),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
