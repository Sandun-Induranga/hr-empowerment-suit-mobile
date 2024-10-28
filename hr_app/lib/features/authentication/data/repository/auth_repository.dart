import 'dart:convert';
import 'package:geolocator/geolocator.dart';
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

  Future<void> setCurrentLocation(String id, Position position) async {
    final String apiUrl = 'http://192.168.8.105:5000/users/$id/location';

    final Map<String, dynamic> locationData = {
      'latitude': position.latitude,
      'longitude': position.longitude,
    };

    try {
      var response = await http.patch(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(locationData),
      );

      print('Response status: ${response.statusCode}');

    } catch (e) {
      print('Error updating employee: $e');
      return null;
    }
  }

  Future<void> updateStatus(String id, bool status) async {
    final String apiUrl = 'http://192.168.8.105:5000/users/$id/status/$status';

    try {
      var response = await http.patch(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      print('Response status: ${response.statusCode}');

    } catch (e) {
      print('Error updating status: $e');
      return null;
    }
  }
}
