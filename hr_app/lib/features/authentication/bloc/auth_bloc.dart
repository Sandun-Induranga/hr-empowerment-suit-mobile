import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_app/features/authentication/data/repository/auth_repository.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final AuthRepository authRepository = AuthRepository();

  AuthBloc() : super(AuthState.initial()) {
    on<AuthEvent>((event, emit) async => switch (event) {
          SetEmployeeIdEvent() => _setEmployeeId(event, emit),
          GetEmployeeByIdEvent() => _getEmployeeById(event, emit),
        });
  }

  void _setEmployeeId(SetEmployeeIdEvent event, Emitter<AuthState> emit) {
    emit(state.clone(
      employeeId: event.employeeId,
    ));
    add(GetEmployeeByIdEvent(employeeId: state.employeeId));
  }

  FutureOr<void> _getEmployeeById(GetEmployeeByIdEvent event, Emitter<AuthState> emit) async {
    final employee = await authRepository.getEmployeeById(event.employeeId);
    emit(state.clone(
      employee: employee,
    ));
  }
}
