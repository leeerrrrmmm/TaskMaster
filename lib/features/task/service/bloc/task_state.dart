import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_master/features/task/data/model/task_model.dart';

@immutable
///
sealed class TaskState extends Equatable {}

///
class TaskBlocInitial extends TaskState {
  @override
  List<Object?> get props => [];
}

///
class TaskBlocLoaded extends TaskState {
  ///
  final List<TaskModel> tasks;

  @override
  List<Object?> get props => [tasks];

  ///
  TaskBlocLoaded(this.tasks);
}

///
class TaskBlocError extends TaskState {
  ///
  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];

  ///
  TaskBlocError(this.errorMessage);
}
