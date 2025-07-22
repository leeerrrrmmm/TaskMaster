import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_master/features/task/data/model/task_model.dart';

@immutable
///
sealed class TaskEvent extends Equatable {}

///
class TaskBlocLoad extends TaskEvent {
  ///

  @override
  List<Object?> get props => [];

  ///
  TaskBlocLoad();
}

///
class AddTask extends TaskEvent {
  ///
  final TaskModel task;

  @override
  List<Object?> get props => [task];

  ///
  AddTask({required this.task});
}

///
class RemoveTask extends TaskEvent {
  ///
  final TaskModel task;

  @override
  List<Object?> get props => [task];

  ///
  RemoveTask({required this.task});
}
