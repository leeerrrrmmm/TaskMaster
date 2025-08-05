import 'package:task_master/data/models/task/task_model.dart';
import 'package:task_master/domain/repository/task_repo.dart';

///
class AddTaskUseCase {
  ///
  final TaskRepository repository;

  ///
  AddTaskUseCase(this.repository);

  ///
  Future<void> call(TaskModel task) => repository.addTask(task);
}
