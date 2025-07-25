import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_master/features/leave/data/model/leave_model.dart';

part 'leave_event.dart';
part 'leave_state.dart';

///
class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  final List<LeaveModel> _leaves = [];

  ///
  LeaveBloc() : super(LeaveInitial()) {
    /// LOAD LEAVES
    on<LeaveLoad>((_, emit) {
      emit(LeaveLoaded(_leaves));
    });

    /// ADD LEAVES
    on<AddLeave>((event, emit) {
      _leaves.add(event.leave);
      emit(LeaveLoaded(_leaves));
    });

    /// REMOVE LEAVES
    on<RemoveLeave>((event, emit) {
      _leaves.removeWhere((el) => el.id == event.leave.id);
      emit(LeaveLoaded(_leaves));
    });
  }
}
