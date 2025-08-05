import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_master/data/models/leave/leave_model.dart';
import 'package:task_master/domain/usecases/leave/add_leave_use_cases.dart';

part 'leave_event.dart';
part 'leave_state.dart';

///
class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  ///
  final AddLeaveUseCases addLeaveUseCases;

  ///
  LeaveBloc(this.addLeaveUseCases) : super(LeaveInitial()) {
    /// LOAD LEAVES
    on<LeaveLoad>((_, emit) {
      emit(LeaveInitial());
    });

    /// ADD LEAVES
    on<AddLeave>((event, emit) async {
      try {
        await addLeaveUseCases(event.leave); // Use repository → Supabase
        emit(LeaveLoaded([event.leave]));
      } catch (e, stackTrace) {
        log('Error adding task: $e', stackTrace: stackTrace);
        emit(const LeaveBlocError('Failed to create task'));
      }
    });

    /// REMOVE LEAVES
    on<RemoveLeave>((_, __) {
      //TODO
    });
  }
}
