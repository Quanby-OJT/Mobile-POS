import 'package:flutter/material.dart';

class Logs extends StatefulWidget {
  const Logs({super.key});

  @override
  State<Logs> createState() => _buildLogsState();
}

class Manager {
  final String profileImage;
  final String fullname;
  final String action;
  final String date;

  Manager({
    required this.profileImage,
    required this.fullname,
    required this.action,
    required this.date,
  });
}

class _buildLogsState extends State<Logs> with SingleTickerProviderStateMixin {
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
      action: "Delete",
      date: "02-14-25 18-45-50",
    ),
    Manager(
      profileImage: "https://via.placeholder.com/150",
      fullname: "Michael D. Smith",
      action: "Update",
      date: "02-14-25 17-30-25",
    ),
    Manager(
      profileImage: "https://via.placeholder.com/150",
      fullname: "Sarah L. Williams",
      action: "Create",
      date: "02-14-25 16-50-40",
    ),
    Manager(
      profileImage: "https://via.placeholder.com/150",
      fullname: "David R. Brown",
      action: "Delete",
      date: "02-14-25 15-10-35",
    ),
    Manager(
      profileImage: "https://via.placeholder.com/150",
      fullname: "Emily T. Davis",
      action: "Update",
      date: "02-14-25 14-55-05",
    ),
    Manager(
      profileImage: "https://via.placeholder.com/150",
      fullname: "Robert W. Garcia",
      action: "Create",
      date: "02-14-25 19-20-45",
    ),
    Manager(
      profileImage: "https://via.placeholder.com/150",
      fullname: "Jessica M. Martinez",
      action: "Delete",
      date: "02-14-25 20-30-15",
    ),
    Manager(
      profileImage: "https://via.placeholder.com/150",
      fullname: "Christopher J. Wilson",
      action: "Update",
      date: "02-14-25 13-45-55",
    ),
    Manager(
      profileImage: "https://via.placeholder.com/150",
      fullname: "Laura E. Anderson",
      action: "Create",
      date: "02-14-25 18-25-30",
    ),
    Manager(
      profileImage: "https://via.placeholder.com/150",
      fullname: "Daniel K. Thomas",
      action: "Delete",
      date: "02-14-25 17-15-20",
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
                          )
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
                            DataColumn(
                              label: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text("Date"),
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
                                  DataCell(Text(manager.action)),
                                  DataCell(Text(manager.date)),
                                  DataCell(Expanded(
                                      child: Row(
                                    children: [
                                      Container(
                                        child: ElevatedButton.icon(
                                          onPressed: () => (),
                                          label: const Text("View"),
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: Size(50, 30),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            backgroundColor: Colors.blue,
                                            foregroundColor: Colors.white,
                                          ),
                                        ),
                                      )
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
