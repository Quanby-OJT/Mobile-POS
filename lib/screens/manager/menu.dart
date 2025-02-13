import 'package:flutter/material.dart';
import 'package:mobile_pos/screens/admin/user_management.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int selectedIndex = 0; // Index for the selected category
  bool isExpanded = false;

  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.local_fire_department, 'label': 'Appetizers and Salads'},
    {'icon': Icons.fastfood, 'label': 'Breads and Bakery'},
    {'icon': Icons.local_pizza, 'label': 'Kids Menu'},
    {'icon': Icons.local_dining, 'label': 'All Day Liberty Gourmet Breakfast'},
    {'icon': Icons.local_cafe, 'label': 'Wraps and Sandwiches'},
    {'icon': Icons.coffee, 'label': 'Main Course'},
    {'icon': Icons.icecream, 'label': 'Desserts'},
    {'icon': Icons.local_cafe, 'label': 'Drinks'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F1F8),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isTablet = constraints.maxWidth > 600;

          return isTablet
              ? Row(
                  children: [
                    Expanded( child: buildMenuSection(isTablet)),
                    Container(width: 300, child: buildOrderSection()),
                  ],
                )
              : Column(
                  children: [
                    Expanded(child: buildMenuSection(isTablet)),
                    Container( child: buildOrderSectionColumn()), // Fixed height for orders on mobile
                  ],
                );
        },
      ),
    );
  }

  Widget buildMenuSection(bool isTablet) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            children: [
              const Text(
                'Order Menu',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const Spacer(),
              SizedBox(
                width: isTablet ? 200 : 150,
                child: TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: 'Search menu...',
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
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(categories.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: isTablet ? 100 : 80,
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: selectedIndex == index ? Colors.white : Color(0xFFC19435),
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: selectedIndex == index ? Colors.white : Color(0xFFC19435)),
                      boxShadow: selectedIndex == index
                          ? [BoxShadow(color: Colors.amber.withOpacity(0.3), blurRadius: 8.0, spreadRadius: 2.0)]
                          : [],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(categories[index]['icon'], color: selectedIndex == index ? Colors.black : Colors.white),
                        const SizedBox(height: 8.0),
                        Text(
                          categories[index]['label'],
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: selectedIndex == index ? Colors.black : Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Order Menu',
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildOrderSection() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
        color: Color(0xFFC19435),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            children: [
              const Expanded(
                child: Text(
                  'Order/s',
                  style: TextStyle(
                    
                     fontSize: 20,
                      color: Colors.white
                      ),
                ),
              ),
              Container(
                height: 250,
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFF0),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Sub Total:',
                          style: TextStyle(
                            color: Colors.black45
                          ),
                        ),
                        Spacer(),
                        Text(
                          "\$12.00",
                          style: TextStyle(
                            color: Colors.black45,
                            
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Tax:',
                          style: TextStyle(
                            color: Colors.black45
                          ),
                        ),
                        Spacer(),
                        Text(
                          "\$2.00",
                          style: TextStyle(
                            color: Colors.black45,
                           
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 150,
                            child: TextFormField(
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Enter amount...',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey
                                  ),
                                  borderRadius: BorderRadius.circular(10)
                                )
                              ),
                            ),
                          ),
                          Spacer(),
                          TextButton(
                            
                            style: TextButton.styleFrom(
                              minimumSize: Size(50, 50),
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              ) // Set width and height
                            ),
                            onPressed: () {
                      
                            }, 
                            child: Text(
                              'Change',
                            
                              style: TextStyle(
                                color: Colors.white,
                                backgroundColor: Colors.green
                              ),
                            )
                            )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Change:',
                          style: TextStyle(
                            color: Colors.black45
                          ),
                        ),
                        Spacer(),
                        Text(
                          "\$2.00",
                          style: TextStyle(
                            color: Colors.black45,
                            
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          
                          style: ElevatedButton.styleFrom(
                            maximumSize: Size(double.infinity, 50),
                            backgroundColor: Color(0xFFC19435),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                        
                          }, 
                          child: Text(
                            'Charge',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                          )),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget buildOrderSection2() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
        color: Color(0xFFEAAE16),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Order/s',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget buildOrderSectionColumn() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isExpanded ? 500 : 300, // Toggle height
      decoration: const BoxDecoration(
        color: Color(0xFFC19435),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: Column(
        children: [
          // Drag Handle (Like a Bottom Sheet)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFC19435),
              elevation: 0
            ),
            onPressed: () {
              setState(() {
                isExpanded = !isExpanded; // Toggle height
              });
            }, 
            child: Image.asset('assets/images/icons8_horizontal_line_48.png', width: 40, height: 20,color: Colors.white,)
            ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Order/s',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserManagement()),
                            );
                },
                child: Text("Orders List Here")
                ),
              
              ), 
            
            // Placeholder for orders
          ),
        ],
      ),
    );
  }
}
