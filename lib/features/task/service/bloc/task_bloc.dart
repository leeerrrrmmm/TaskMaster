import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_master/domain/usecases/task/add_task_use_case.dart';
import 'package:task_master/features/task/service/bloc/task_event.dart';
import 'package:task_master/features/task/service/bloc/task_state.dart';

///
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  ///

  final AddTaskUseCase addTaskUseCase;

  ///
  TaskBloc({required this.addTaskUseCase}) : super(TaskBlocInitial()) {
    on<TaskBlocLoad>((_, emit) async {
      // Add Supabase loading logic here later
      emit(TaskBlocInitial());
    });

    on<AddTask>((event, emit) async {
      try {
        await addTaskUseCase(event.task); // Use repository → Supabase
        emit(TaskBlocLoaded([event.task]));
      } catch (e, stackTrace) {
        log('Error adding task: $e', stackTrace: stackTrace);
        emit(TaskBlocError('Failed to create task'));
      }
    });

    on<RemoveTask>((_, emit) async {
      // Implement Supabase deletion logic by task.id here later
      // Leave as is for now

      emit(TaskBlocInitial());
    });
  }
}
