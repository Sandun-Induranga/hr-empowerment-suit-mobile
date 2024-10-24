sealed class AuthEvent {}

class SetEmployeeIdEvent extends AuthEvent {
  final String employeeId;

  SetEmployeeIdEvent({
    required this.employeeId,
  });
}

class GetEmployeeByIdEvent extends AuthEvent {
  final String employeeId;

  GetEmployeeByIdEvent({
    required this.employeeId,
  });
}
