// // services/api_service.dart
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ManagerService {
//   // Function to send product data (name and quantity) to the backend
//   Future<void> sendManagerData(String name, String middle, String last,
//       String email, String birthday) async {
//     try {
//       var uri = Uri.parse('http://localhost:3000/connection/add-manager');
//       var request = http.MultipartRequest('POST', uri);

//       request.fields['name'] = name;
//       request.fields['middle'] = middle;
//       request.fields['last'] = last;
//       request.fields['birthday'] = birthday;
//       request.fields['email'] = email;

//       // request.files.add(
//       //   http.MultipartFile.fromBytes(
//       //     'image',
//       //     imageBytes,
//       //     filename: fileName,
//       //     contentType: MediaType('image', 'jpeg'),
//       //   ),
//       // );

//       var response = await request.send();
//       if (response.statusCode == 200) {
//         var responseBody = await response.stream.bytesToString();
//         Map<String, dynamic> jsonData = jsonDecode(responseBody);
//         return jsonData['imageUrl'];
//       } else {
//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }
// }
