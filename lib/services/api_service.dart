import 'dart:typed_data';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ApiService {
  static Future<String?> uploadImage(Uint8List imageBytes, String fileName,
      String name, String quantity, String price) async {
    try {
      var uri = Uri.parse('http://localhost:3000/connection/add-product');
      var request = http.MultipartRequest('POST', uri);

      request.fields['name'] = name;
      request.fields['quantity'] = quantity;
      request.fields['price'] = price;

      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          imageBytes,
          filename: fileName,
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        Map<String, dynamic> jsonData = jsonDecode(responseBody);
        return jsonData['imageUrl'];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Function to fetch all products
  static Future<List<dynamic>> fetchProducts() async {
    try {
      var uri = Uri.parse('http://localhost:3000/connection/all-products');
      var response = await http.get(uri);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Error fetching products: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Exception: $e");
      return [];
    }
  }
}
