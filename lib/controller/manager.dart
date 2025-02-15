// controllers/product_controller.dart
import 'dart:typed_data';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ManagerController {
  // Create an instance of the ApiService to make API calls
  // final ManagerService _managerService = ManagerService();

  // Function to validate and send the product name and quantity to the backend
  Future<String> submitManager(
      Uint8List imageBytes,
      String fileName,
      String name,
      String middle,
      String last,
      String role,
      String activation,
      String email,
      String birthday) async {
    try {
      var uri = Uri.parse('http://localhost:3000/connection/add-manager');
      var request = http.MultipartRequest('POST', uri);

      request.fields['name'] = name;
      request.fields['middle'] = middle;
      request.fields['last'] = last;
      request.fields['birthday'] = birthday;
      request.fields['email'] = email;

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
        return "";
      }
    } catch (e) {
      return "Error: ";
    }

    // Check if either field is empty
    // if (Name.isEmpty ||
    //     Middle.isEmpty ||
    //     Last.isEmpty ||
    //     Email.isEmpty ||
    //     Birthday.isEmpty) {
    //   print("Fill all the required fields");
    //   return;
    // }
    // // Call the service to send both product name and quantity
    // await _managerService.sendManagerData(
    //   Name,
    //   Middle,
    //   Last,
    //   Email,
    //   Birthday,
    // );
    // print(Name + ' ' + Middle + ' ' + Last + ' ' + Email);
  }
}
