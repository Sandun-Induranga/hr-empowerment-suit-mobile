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
          UpdateCurrentLocation() => _updateCurrentLocation(event, emit),
          UpdateStatus() => _updateStatus(event, emit),
    LoginEvent() => _login(event, emit),
        });
  }

  void _setEmployeeId(SetEmployeeIdEvent event, Emitter<AuthState> emit) {
    emit(state.clone(
      employeeId: event.employeeId,
    ));
    add(GetEmployeeByIdEvent(employeeId: event.employeeId));
  }

  FutureOr<void> _getEmployeeById(
      GetEmployeeByIdEvent event, Emitter<AuthState> emit) async {
    final employee = await authRepository.getEmployeeById(event.employeeId);
    emit(state.clone(
      employee: employee,
      status: bool.parse(employee?.status ?? 'false')
    ));
  }

  void _updateCurrentLocation(
      UpdateCurrentLocation event, Emitter<AuthState> emit) {
    authRepository.setCurrentLocation(state.employeeId, event.position);
  }

  FutureOr<void> _updateStatus(
      UpdateStatus event, Emitter<AuthState> emit) async {
    await authRepository.updateStatus(
      state.employeeId,
      !state.status
    );
    emit(state.clone(
      status: !state.status,
    ));
  }

  FutureOr<void> _login(
      LoginEvent event, Emitter<AuthState> emit) async {
    try{
      emit(state.clone(
        loginStatus: LoginStatus.submitting,
      ));
      await authRepository.login(event.email, event.password);
      emit(state.clone(
        loginStatus: LoginStatus.success,
      ));
    }catch (e){
      emit(state.clone(
        loginStatus: LoginStatus.error,
      ));
    }
  }
}
