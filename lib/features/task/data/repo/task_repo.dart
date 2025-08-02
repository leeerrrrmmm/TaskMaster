import 'package:task_master/features/task/data/model/task_model.dart';

///
class TaskRepo {
  final List<TaskModel> _tasks = [];

  ///
  List<TaskModel> getTasks() => List.unmodifiable(_tasks);

  ///
  void addTask(TaskModel task) {
    _tasks.add(task);
  }
}
