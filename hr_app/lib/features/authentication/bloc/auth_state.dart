class AuthState {
  final String employeeId;
  final Map<String, dynamic>? employee;

  AuthState({required this.employeeId, this.employee});

  static AuthState initial() => AuthState(
        employeeId: '',
        employee: null,
      );

  AuthState clone({
    String? employeeId,
    Map<String, dynamic>? employee,
  }) {
    return AuthState(
      employeeId: employeeId ?? this.employeeId,
      employee: employee ?? this.employee,
    );
  }
}
