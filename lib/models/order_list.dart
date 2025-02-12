class OrderList {
  final String name;
  final String email;

  OrderList({required this.name, required this.email});

  // Convert JSON to User object
  factory OrderList.fromJson(Map<String, dynamic> json) {
    return OrderList(
      name: json['name'],
      email: json['email'],
    );
  }

  // Convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
    };
  }
}
