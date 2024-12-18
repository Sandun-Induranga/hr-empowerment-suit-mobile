import 'dart:convert';
import 'package:hr_app/features/home/data/model/attendance.dart';
import 'package:hr_app/features/home/data/model/leave_request.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/ApiConstants.dart';
import '../model/project.dart';

class HomeRepository {
  Future<List<Attendance>> getAttendanceData(String id) async {
    final String apiUrl = '$baseUrl/attendance/$id';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Attendance>.from(data.map((x) => Attendance.fromJson(x)));
      } else {
        print('Failed to load attendance. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching attendance: $e');
      return [];
    }
  }

  Future<List<Project>> getProjectData(String id) async {
    final String apiUrl = '$baseUrl/projects/$id/users';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Project>.from(data.map((x) => Project.fromJson(x)));
      } else {
        print('Failed to load projects. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching projects: $e');
      return [];
    }
  }

  Future<void> requestLeave(LeaveRequest leave) async {
    const String apiUrl = '$baseUrl/leaves';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(leave.toJson()),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        print('Leave request successful');
      } else {
        print('Failed to create leave. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating leave: $e');
    }
  }
}
