import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repository/home_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final HomeRepository homeRepository = HomeRepository();

  HomeBloc() : super(HomeState.initial()) {
    on<HomeEvent>((event, emit) async => switch (event) {
      GetAttendanceDataEvent() => _getAttendanceData(event, emit),
    });
  }

  FutureOr<void> _getAttendanceData(GetAttendanceDataEvent event, Emitter<HomeState> emit) async {
    final attendanceData = await homeRepository.getAttendanceData(event.userId);

    emit(state.clone(
      attendanceList: attendanceData,
    ));
  }
}
