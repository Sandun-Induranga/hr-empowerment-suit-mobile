import 'dart:ffi';

class Employee {
  final String id;
  final String employeeId;
  final String name;
  final String picture;
  final String address;
  final DateTime birthday;
  final String email;
  final String mobile;
  final String position;
  final String department;
  final double salary;
  final String gender;
  final String status;

  Employee({
    required this.id,
    required this.employeeId,
    required this.name,
    required this.picture,
    required this.address,
    required this.birthday,
    required this.email,
    required this.mobile,
    required this.position,
    required this.department,
    required this.salary,
    required this.gender,
    required this.status,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['_id'] ?? '',
      employeeId: json['employee']['employeeId'] ?? '',
      name: json['employee']['name'] ?? '',
      picture: json['employee']['picture'] ?? '',
      address: json['employee']['address'] ?? '',
      birthday: DateTime.tryParse(json['employee']['birthday'] ?? '') ?? DateTime.now(),
      email: json['employee']['email'] ?? '',
      mobile: json['employee']['mobile'] ?? '',
      position: json['employee']['position'] ?? '',
      department: json['employee']['department'] ?? '',
      salary: (json['employee']['salary'] != null) ? json['employee']['salary'].toDouble() : 0.0,
      gender: json['employee']['gender'] ?? '',
      status: (json['employee']['status'] ?? '').toString() == 'true' ? 'true' : 'false',
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
      'status': status,
    };
  }
}
