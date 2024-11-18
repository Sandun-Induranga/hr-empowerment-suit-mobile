import 'package:hr_app/features/authentication/data/model/employee.dart';

enum LoginStatus { initial, submitting, success, error }

class AuthState {
  final String employeeId;
  final Employee? employee;
  final LoginStatus loginStatus;
  final bool status;

  AuthState({
    required this.employeeId,
    this.employee,
    required this.loginStatus,
    required this.status,
  });

  static AuthState initial() => AuthState(
        employeeId: '',
        employee: null,
        loginStatus: LoginStatus.initial,
        status: false,
      );

  AuthState clone({
    String? employeeId,
    Employee? employee,
    LoginStatus? loginStatus,
    bool? status,
  }) {
    return AuthState(
      employeeId: employeeId ?? this.employeeId,
      employee: employee ?? this.employee,
      loginStatus: loginStatus ?? this.loginStatus,
      status: status ?? this.status,
    );
  }
}
