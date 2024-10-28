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
