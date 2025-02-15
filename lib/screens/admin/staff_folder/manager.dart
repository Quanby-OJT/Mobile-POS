import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mobile_pos/services/api_service.dart';

import 'package:mobile_pos/controller/manager.dart';

class buildManagerTable extends StatefulWidget {
  const buildManagerTable({super.key});

  @override
  State<buildManagerTable> createState() => _buildManagerTableState();
}

class Manager {
  final String profileImage;
  final String fullname;
  final String contact;
  final String activation;
  final String status;

  Manager({
    required this.profileImage,
    required this.fullname,
    required this.contact,
    required this.activation,
    required this.status,
  });
}

class _buildManagerTableState extends State<buildManagerTable>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _middleController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _activationController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  final ManagerController _managerController = ManagerController();

  Uint8List? _imageBytes;
  String? _imageName;
  String? _imageUrl;
  List<dynamic> _products = [];
  bool _showForm = false;

  String numberSet = '20';
  int currentPage = 1;

  final int totalPages = 5;

  void _nextPage(int page) {
    setState(() {
      currentPage = page;
    });
  }

  List<Manager> managers = [
    Manager(
      profileImage: "https://via.placeholder.com/150",
      fullname: "Alice B. Johnson",
      contact: "1231231234",
      activation: 'enabled',
      status: 'active',
    )
  ];

  void _showManagerFilter() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Filter Manager'),
            ));
  }

  void _onExportPressed(BuildContext context, String format) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Exporting as $format...")),
    );
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

  void _onAddManager(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Manager"),
          content: Container(
            width: 500, // Adjust width to fit the content
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
                        decoration: _inputDecoration("First Name"),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        cursorColor: Colors.black,
                        controller: _middleController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration("Middle Name"),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        cursorColor: Colors.black,
                        controller: _lastController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration("Last Name"),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        cursorColor: Colors.black,
                        controller: _birthdayController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration("Birthday"),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        cursorColor: Colors.black,
                        controller: _emailController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration("Email"),
                      ),
                      SizedBox(height: 10),
                      DropDownTextField(
                        textFieldDecoration:
                            _inputDecoration("Select an activation"),
                        dropDownList: [
                          DropDownValueModel(
                              name: 'disable', value: 'disabled'),
                          DropDownValueModel(name: 'enable', value: 'enabled'),
                        ],
                        onChanged: (value) {
                          print("Selected: ${value.name}");
                          _activationController.text = value.name;
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
                        onPressed: () {
                          _pickImage;
                        },
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
              onPressed: () async {
                String name = _nameController.text;
                String middle = _middleController.text;
                String last = _lastController.text;
                String birthday = _birthdayController.text;
                String email = _emailController.text;
                String activation = _activationController.text;
                String role = "Manager";
                _storeImage(
                    name, middle, last, birthday, email, role, activation);

                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(100, 50),
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              child: Text(
                "Add manager",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _storeImage(String name, String middle, String last,
      String birthday, String email, String role, String activation) async {
    if (_imageBytes == null || _imageName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select an image first!")),
      );
      return;
    }
    //String category = _categoryController.text.trim();

    if (name.isEmpty ||
        middle.isEmpty ||
        last.isEmpty ||
        birthday.isEmpty ||
        email.isEmpty ||
        role.isEmpty ||
        activation.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields!")),
      );
      return;
    }

    String? response = await _managerController.submitManager(
      _imageBytes!,
      _imageName!,
      name,
      last,
      middle,
      birthday,
      email,
      role,
      activation,
    );

    if (response != null) {
      setState(() {
        _imageUrl = response;
        _showForm = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Image uploaded successfully!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error uploading image!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
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
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  prefixIcon: const Icon(Icons.search,
                                      color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton.icon(
                            onPressed: () => _showManagerFilter(),
                            icon: const Icon(Icons.arrow_drop_down),
                            label: const Text("Filter"),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(100, 55),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor:
                                  const Color.fromARGB(255, 215, 171, 11),
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          PopupMenuButton<String>(
                            onSelected: (value) =>
                                _onExportPressed(context, value),
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: "PDF",
                                child: Text("Export as PDF"),
                              ),
                              const PopupMenuItem(
                                value: "CSV",
                                child: Text("Export as CSV"),
                              ),
                            ],
                            child: ElevatedButton.icon(
                              onPressed: null,
                              icon: const Icon(Icons.file_download),
                              label: const Text("Export"),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(100, 55),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton.icon(
                            onPressed: () => _onAddManager(context),
                            icon: const Icon(Icons.add),
                            label: const Text("Add Manager"),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(100, 55),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 500,
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          columns: [
                            DataColumn(
                              label: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text("Profile"),
                                    SizedBox(width: 5),
                                    IconButton(
                                      onPressed: () {
                                        print('Sort Action');
                                      },
                                      icon: const Icon(
                                        Icons.unfold_more,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text("Full Name"),
                                    SizedBox(width: 5),
                                    IconButton(
                                      onPressed: () {
                                        print('Sort Action');
                                      },
                                      icon: const Icon(Icons.unfold_more),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text("Contact"),
                                    SizedBox(width: 5),
                                    IconButton(
                                      onPressed: () {
                                        print('Sort Action');
                                      },
                                      icon: const Icon(Icons.unfold_more),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text("Activation"),
                                    SizedBox(width: 5),
                                    IconButton(
                                      onPressed: () {
                                        print('Sort Action');
                                      },
                                      icon: const Icon(Icons.unfold_more),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text("Status"),
                                    SizedBox(width: 5),
                                    IconButton(
                                      onPressed: () {
                                        print('Sort Action');
                                      },
                                      icon: const Icon(Icons.unfold_more),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text("Action"),
                                    SizedBox(width: 5),
                                    IconButton(
                                      onPressed: () {
                                        print('Sort Action');
                                      },
                                      icon: const Icon(Icons.unfold_more),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                          rows: managers
                              .map(
                                (manager) => DataRow(cells: [
                                  DataCell(CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(manager.profileImage),
                                  )),
                                  DataCell(Text(manager.fullname)),
                                  DataCell(Text(manager.contact)),
                                  DataCell(Text(manager.activation)),
                                  DataCell(SizedBox(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 73, 196, 6),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Text(manager.status),
                                    ),
                                  )),
                                  DataCell(Expanded(
                                      child: Row(
                                    children: [
                                      Container(
                                          child: Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              color: Colors.green,
                                              size: 25,
                                            ),
                                            onPressed: () {},
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 25,
                                            ),
                                            onPressed: () {},
                                          ),
                                        ],
                                      ))
                                    ],
                                  )))
                                ]),
                              )
                              .toList(),
                        ),
                      )),
                ),
                resultControl()
              ],
            )));
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
}
