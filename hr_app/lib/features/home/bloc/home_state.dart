import 'package:hr_app/features/home/data/model/attendance.dart';

class HomeState {
  final List<Attendance> attendanceList;

  HomeState({
    required this.attendanceList,
  });

  static HomeState initial() => HomeState(
        attendanceList: [],
      );

  HomeState clone({
    List<Attendance>? attendanceList,
  }) {
    return HomeState(
      attendanceList: attendanceList ?? this.attendanceList,
    );
  }
}
