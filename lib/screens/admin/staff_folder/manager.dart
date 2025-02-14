import 'package:flutter/material.dart';

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
    ),
    Manager(
      profileImage: "https://via.placeholder.com/150",
      fullname: "Michael C. Smith",
      contact: "1231231234",
      activation: 'disabled',
      status: 'inactive',
    ),
    Manager(
      profileImage: "https://via.placeholder.com/150",
      fullname: "Sarah D. Lee",
      contact: "4564564567",
      activation: 'enabled',
      status: 'active',
    ),
    Manager(
      profileImage: "https://via.placeholder.com/150",
      fullname: "Robert T. Brown",
      contact: "7897897890",
      activation: 'enabled',
      status: 'active',
    ),
    Manager(
      profileImage: "https://via.placeholder.com/150",
      fullname: "Jessica M. Garcia",
      contact: "1112223333",
      activation: 'disabled',
      status: 'inactive',
    ),
    Manager(
      profileImage: "https://via.placeholder.com/150",
      fullname: "David R. Wilson",
      contact: "5556667777",
      activation: 'enabled',
      status: 'active',
    ),
    Manager(
      profileImage: "https://via.placeholder.com/150",
      fullname: "Emily H. Martinez",
      contact: "9998887777",
      activation: 'enabled',
      status: 'active',
    ),
    Manager(
      profileImage: "https://via.placeholder.com/150",
      fullname: "Daniel O. Clark",
      contact: "4445556666",
      activation: 'disabled',
      status: 'inactive',
    ),
    Manager(
      profileImage: "https://via.placeholder.com/150",
      fullname: "Laura P. White",
      contact: "7778889999",
      activation: 'enabled',
      status: 'active',
    ),
    Manager(
      profileImage: "https://via.placeholder.com/150",
      fullname: "James L. Hernandez",
      contact: "3334445555",
      activation: 'enabled',
      status: 'active',
    ),
    Manager(
      profileImage: "https://via.placeholder.com/150",
      fullname: "Alice B. Johnson",
      contact: "0987654321",
      activation: 'enabled',
      status: 'active',
    ),
    Manager(
      profileImage: "https://via.placeholder.com/150",
      fullname: "Michael C. Smith",
      contact: "1231231234",
      activation: 'disabled',
      status: 'inactive',
    ),
    Manager(
      profileImage: "https://via.placeholder.com/150",
      fullname: "Sarah D. Lee",
      contact: "4564564567",
      activation: 'enabled',
      status: 'active',
    ),
    Manager(
      profileImage: "https://via.placeholder.com/150",
      fullname: "Robert T. Brown",
      contact: "7897897890",
      activation: 'enabled',
      status: 'active',
    ),
    Manager(
      profileImage: "https://via.placeholder.com/150",
      fullname: "Jessica M. Garcia",
      contact: "1112223333",
      activation: 'disabled',
      status: 'inactive',
    ),
    Manager(
      profileImage: "https://via.placeholder.com/150",
      fullname: "David R. Wilson",
      contact: "5556667777",
      activation: 'enabled',
      status: 'active',
    ),
    Manager(
      profileImage: "https://via.placeholder.com/150",
      fullname: "Emily H. Martinez",
      contact: "9998887777",
      activation: 'enabled',
      status: 'active',
    ),
    Manager(
      profileImage: "https://via.placeholder.com/150",
      fullname: "Daniel O. Clark",
      contact: "4445556666",
      activation: 'disabled',
      status: 'inactive',
    ),
    Manager(
      profileImage: "https://via.placeholder.com/150",
      fullname: "Laura P. White",
      contact: "7778889999",
      activation: 'enabled',
      status: 'active',
    ),
    Manager(
      profileImage: "https://via.placeholder.com/150",
      fullname: "James L. Hernandez",
      contact: "3334445555",
      activation: 'enabled',
      status: 'active',
    ),
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

  void _onAddPressed(BuildContext context) {}
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
                            onPressed: () => _onAddPressed(context),
                            icon: const Icon(Icons.add),
                            label: const Text("Add"),
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
}
