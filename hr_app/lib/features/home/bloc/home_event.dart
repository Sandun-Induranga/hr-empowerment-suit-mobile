sealed class HomeEvent {}

class GetAttendanceDataEvent extends HomeEvent {
  final String userId;

  GetAttendanceDataEvent({
    required this.userId,
  });
}
