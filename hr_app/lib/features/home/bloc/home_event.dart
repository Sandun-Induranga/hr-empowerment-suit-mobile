import '../data/model/leave_request.dart';

sealed class HomeEvent {}

class GetAttendanceDataEvent extends HomeEvent {
  final String userId;

  GetAttendanceDataEvent({
    required this.userId,
  });
}

class GetProjectsDataEvent extends HomeEvent {
  final String userId;

  GetProjectsDataEvent({
    required this.userId,
  });
}

class RequestLeaveEvent extends HomeEvent {
  final LeaveRequest leaveRequest;

  RequestLeaveEvent({
    required this.leaveRequest,
  });
}
