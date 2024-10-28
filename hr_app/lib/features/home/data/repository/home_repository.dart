import 'dart:convert';
import 'package:hr_app/features/home/data/model/attendance.dart';
import 'package:http/http.dart' as http;

import '../model/project.dart';

class HomeRepository {
  Future<List<Attendance>> getAttendanceData(String id) async {
    final String apiUrl = 'http://192.168.8.105:5000/attendance/$id';

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
    final String apiUrl = 'http://192.168.8.105:5000/projects/$id/users';

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
}
