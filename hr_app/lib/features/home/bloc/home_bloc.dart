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
          GetProjectsDataEvent() => _getProjectsData(event, emit),
          RequestLeaveEvent() => _requestLeave(event, emit),
        });
  }

  FutureOr<void> _getAttendanceData(
      GetAttendanceDataEvent event, Emitter<HomeState> emit) async {
    final attendanceData = await homeRepository.getAttendanceData(event.userId);

    final limitedAttendanceData = attendanceData.length > 5
        ? attendanceData.sublist(0, 5)
        : attendanceData;

    emit(state.clone(
      attendanceList: limitedAttendanceData,
    ));
  }

  FutureOr<void> _getProjectsData(
      GetProjectsDataEvent event, Emitter<HomeState> emit) async {
    final projects = await homeRepository.getProjectData(event.userId);

    emit(state.clone(
      projectsList: projects,
    ));
  }

  FutureOr<void> _requestLeave(
      RequestLeaveEvent event, Emitter<HomeState> emit) async {
    try{
      emit(state.clone(
        requestStatus: RequestStatus.submitting,
      ));
      await homeRepository.requestLeave(event.leaveRequest);
      emit(state.clone(
        requestStatus: RequestStatus.success,
      ));
    }catch (e){
      emit(state.clone(
        requestStatus: RequestStatus.error,
      ));
    }
  }
}
