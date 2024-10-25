class Employee {
  final String id;
  final String employeeId;
  final String name;
  final String address;
  final DateTime birthday;
  final String email;
  final String mobile;
  final String position;
  final String department;
  final double salary;
  final String gender;

  Employee({
    required this.id,
    required this.employeeId,
    required this.name,
    required this.address,
    required this.birthday,
    required this.email,
    required this.mobile,
    required this.position,
    required this.department,
    required this.salary,
    required this.gender,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['_id'] ?? '',
      employeeId: json['employeeId'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      birthday: DateTime.tryParse(json['birthday'] ?? '') ?? DateTime.now(),
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      position: json['position'] ?? '',
      department: json['department'] ?? '',
      salary: (json['salary'] != null) ? json['salary'].toDouble() : 0.0,
      gender: json['gender'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'employeeId': employeeId,
      'name': name,
      'address': address,
      'birthday': birthday.toIso8601String(),
      'email': email,
      'mobile': mobile,
      'position': position,
      'department': department,
      'salary': salary,
      'gender': gender,
    };
  }
}
