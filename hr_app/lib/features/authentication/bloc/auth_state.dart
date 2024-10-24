class AuthState {
  final String employeeId;

  AuthState({required this.employeeId});

  static AuthState initial() => AuthState(
        employeeId: '',
      );

  AuthState clone({
    String? employeeId,
  }) {
    return AuthState(
      employeeId: employeeId ?? this.employeeId,
    );
  }
}
