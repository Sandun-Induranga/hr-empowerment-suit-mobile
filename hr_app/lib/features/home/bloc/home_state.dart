import 'package:hr_app/features/home/data/model/attendance.dart';

import '../data/model/project.dart';

enum RequestStatus { initial, submitting, success, error }

class HomeState {
  final List<Attendance> attendanceList;
  final List<Project> projectsList;
  final RequestStatus requestStatus;

  HomeState({
    required this.attendanceList,
    required this.projectsList,
    required this.requestStatus,
  });

  static HomeState initial() => HomeState(
        attendanceList: [],
        projectsList: [],
        requestStatus: RequestStatus.initial,
      );

  HomeState clone({
    List<Attendance>? attendanceList,
    List<Project>? projectsList,
    RequestStatus? requestStatus,
  }) {
    return HomeState(
      attendanceList: attendanceList ?? this.attendanceList,
      projectsList: projectsList ?? this.projectsList,
      requestStatus: requestStatus ?? this.requestStatus,
    );
  }
}
