import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:hr_app/core/constants/ApiConstants.dart';
import 'package:http/http.dart' as http;

import '../../../../core/utils/shared_preferences_service.dart';
import '../model/employee.dart';

class AuthRepository {
  Future<Employee?> getEmployeeById(String id) async {
    final String apiUrl = '$baseUrl/users/$id';

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
    final String apiUrl = '$baseUrl/users/$id/location';

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
    final String apiUrl = '$baseUrl/users/$id/status/$status';

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

  Future<void> login(email, password) async {
    // Prepare the login request body
    final Map<String, String> requestBody = {
      'email': email,
      'password': password,
    };

    // Send the login request
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 201) {
      // Successful login
      final Map<String, dynamic> responseBody = json.decode(response.body);
      final String accessToken = responseBody['access_token'];

      // Store the token securely (e.g., using Flutter Secure Storage)
      // Navigate to the next screen
      await SharedPreferencesService().setToken(accessToken);
      // context.read<AuthBloc>().add(SetEmployeeIdEvent(employeeId: getEmployeeIdFromToken(accessToken) ?? ''));
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const BottomNavigationView(),
      //   ),
      // );
    } else {
      // Handle login failure
      throw Exception('Login Failed');
    }
  }
}
