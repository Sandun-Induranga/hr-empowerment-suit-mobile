import 'package:geolocator/geolocator.dart';

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

class UpdateCurrentLocation extends AuthEvent {
  final Position position;

  UpdateCurrentLocation({
    required this.position,
  });
}

class UpdateStatus extends AuthEvent {
  final bool status;

  UpdateStatus({
    required this.status,
  });
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({
    required this.email,
    required this.password,
  });
}
