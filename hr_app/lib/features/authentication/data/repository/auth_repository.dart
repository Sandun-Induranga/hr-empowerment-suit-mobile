import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/employee.dart';

class AuthRepository {
  Future<Employee?> getEmployeeById(String id) async {
    final String apiUrl = 'http://192.168.8.105:5000/users/$id';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> employeeData = json.decode(response.body);
        return Employee.fromJson(employeeData);
      } else {
        print('Failed to load employee. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching employee: $e');
      return null;
    }
  }
}
