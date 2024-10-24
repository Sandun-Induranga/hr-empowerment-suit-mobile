import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.initial()) {
    on<AuthEvent>((event, emit) async => switch (event) {
          SetEmployeeIdEvent() => _setEmployeeId(event, emit),
        });
  }

  void _setEmployeeId(SetEmployeeIdEvent event, Emitter<AuthState> emit) {
    emit(state.clone(
      employeeId: event.employeeId,
    ));
  }
}
