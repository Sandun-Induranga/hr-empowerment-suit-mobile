import 'package:hr_app/features/home/data/model/attendance.dart';

import '../data/model/project.dart';

class HomeState {
  final List<Attendance> attendanceList;
  final List<Project> projectsList;

  HomeState({
    required this.attendanceList,
    required this.projectsList,
  });

  static HomeState initial() => HomeState(
        attendanceList: [],
        projectsList: [],
      );

  HomeState clone({
    List<Attendance>? attendanceList,
    List<Project>? projectsList,
  }) {
    return HomeState(
      attendanceList: attendanceList ?? this.attendanceList,
      projectsList: projectsList ?? this.projectsList,
    );
  }
}
