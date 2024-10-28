import 'dart:convert';
import 'package:hr_app/features/home/data/model/attendance.dart';
import 'package:http/http.dart' as http;

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
}
