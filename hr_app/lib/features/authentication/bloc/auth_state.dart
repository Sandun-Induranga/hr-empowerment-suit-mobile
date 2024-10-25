import 'package:hr_app/features/authentication/data/model/employee.dart';

class AuthState {
  final String employeeId;
  final Employee? employee;

  AuthState({
    required this.employeeId,
    this.employee,
  });

  static AuthState initial() => AuthState(
        employeeId: '',
        employee: null,
      );

  AuthState clone({
    String? employeeId,
    Employee? employee,
  }) {
    return AuthState(
      employeeId: employeeId ?? this.employeeId,
      employee: employee ?? this.employee,
    );
  }
}
