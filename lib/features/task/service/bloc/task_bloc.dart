import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_master/features/task/data/model/task_model.dart';
import 'package:task_master/features/task/service/bloc/task_event.dart';
import 'package:task_master/features/task/service/bloc/task_state.dart';

///
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final List<TaskModel> _tasks = [];

  ///
  TaskBloc() : super(TaskBlocInitial()) {
    on<TaskBlocLoad>((_, emit) async {
      try {
        emit(TaskBlocLoaded(List.from(_tasks)));
      } catch (e) {
        log('Error load tasks');
      }
    });

    on<AddTask>((event, emit) async {
      _tasks.add(event.task);
      emit(TaskBlocLoaded(List<TaskModel>.from(_tasks)));
    });

    on<RemoveTask>((event, emit) async {
      _tasks.removeWhere((task) => task.id == event.task.id);
      emit(TaskBlocLoaded(List<TaskModel>.from(_tasks)));
    });
  }
}
